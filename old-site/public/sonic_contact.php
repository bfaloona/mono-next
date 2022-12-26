<?php
/*
---------------------------------------------------
	SonicFog Web Development
	-------------------------------------------
	a division of SeniorGlobe Media Inc
	-------------------------------------------
	This code is Copyright Protected
	SeniorGlobe Media Inc. 2005
---------------------------------------------------
*/
//This script is easy to use. Just include this page in any of your php pages and it will proccess a custom form.
//You can add as many input fields as you like to customize your form, they will all be processed.

//Settings to edit
$MailSubject = "Shakespeare's Monologues Contact Form"; // edit the subject of the email
$CompanyName = "Shakespeare's Monologues"; //edit -  this could be a division like Support Team, this shows on the confirmation page
//change these to make your subject dropdown and handle mail routing, add as many as you like
$SubjectArray = array(
	"Contact"				=>	"webform@shakespeare-monologues.org",
	"Support"	=>	"webform@shakespeare-monologues.org",
	"Corrections"	=>	"webform@shakespeare-monologues.org",
	"Other"					=>	"webform@shakespeare-monologues.org"
);
//enter blocked ip addresses below separated by commas
$BlockedIP = "1.1.1.1";
//enter blocked email addresses below between the quotes
$BlockedEmail = "someone@aol.com, spammer@aol.com";
//Sonic Version
$sonic_ver =  "1.0.1";
//1.0.1 added security and routing
function valid_email($email)
{
	// Check for a valid email address.
	$regexp = "^([_a-z0-9-]+)(\.[_a-z0-9-]+)*@([a-z0-9-]+)(\.[a-z0-9-]+)*(\.[a-z]{2,6})$";
	// Get the hostname.
	$fromHost = explode("@", $_POST['email']);
    // Test for both valid syntax and a valid server.
	if ( !eregi($regexp, $_POST['email']) || !checkdnsrr($fromHost[1], "MX") ) {
        return false;
	}else{
		return true;
	}
}
if($_POST["step"] == "send"){
	$send_email = "yes";
	//lets try to make it no
	//no name, you can't contact us without a name
	if(!$_POST["name"]){
		$send_email = "no";
		$error_message_name =  "<center><font color=red><b>Please enter your name below.</b></font></center>";
	}
	//contact pref is phone but no phone number entered
	if($_POST["contact_preference"] == "phone" && !$_POST["phone"]){
		$send_email = "no";
		$error_message_phone =  "<center><font color=red><b>You chose phone as your contact preference, but
		you did not enter your phone number. Please enter it now.</b></font></center>";
	}
	if($_POST["rc"] != $_POST["rc2"]){
		$send_email = "no";
		$error_message_security =  "<center><font color=red><b>Your security characters did not match ours. 
		Please try again.</b></font><br>IP Address Logged As: $REMOTE_ADDR</center>";
	}
	//check for valid email format
	if (!valid_email($email)){
		$send_email = "no";
		$error_message_email =  "<center><font color=red><b>Your email address appears invalid. Please 
		re-enter it below.</b></font></center>";
	}
	//check for blocked ips
	$sonicx = strstr($BlockedIP, getenv('REMOTE_ADDR'));
	if($sonicx == TRUE){
		$send_email = "no";
		$error_message .= "<center><b>Sorry but we could not process your form at this time.</b></center>";
		$error_type = "fatal";
	}
	$sonicxemail = @strstr($BlockedEmail, $_POST["email"]);
	//echo "Post email =". $_POST["email"];
	//echo "sonicxemail =". $sonicxemail;
	if($sonicxemail == TRUE){
		$send_email = "no";
		$error_message .= "<center><b>Sorry but we could not process your form at this time.";
		$error_type = "fatal";
	}
	if (preg_match ("/".str_replace("www.", "", $_SERVER["SERVER_NAME"])."/i", $_SERVER["HTTP_REFERER"]) 
	&& ($send_email == "yes")){
		//start formatting and building the message
		// handle post strings
		reset($_POST);
			while(list($key, $val) = each($_POST)) {
				$GLOBALS[$key] = $val;
				if (is_array($val)) { 
					$sonicMessage .= "<b>$key:</b> ";
					foreach ($val as $vala) { 
						$vala =stripslashes($vala);
						$vala = htmlspecialchars($vala);
						$sonicMessage .= "$vala, ";
					} 
					$sonicMessage .= "<br>\n";
					}else{
					$val = stripslashes($val);
					if (($key == "Submit") || ($key == "submit")){
				
					}else{ 	
					if ($val == ""){
						$sonicMessage .= "$key: - <br>\n";
					}else{
						$sonicMessage .= "<b>$key:</b> $val<br>\n";
						}
					}
				}
			} // end while
		//determine the mail routing
		foreach($SubjectArray as $key=>$val){
		  	if($_POST["subject"] == $key){
				$MailToAddress = $val;
			} //end if
		  } //end foreach
		$sonicMessage .= "<font size=3D1><br><br>\n Sender IP: ".getenv('REMOTE_ADDR')."</font></font></body></html>";	
   		$sonic_what = array("/To:/i", "/Cc:/i", "/Bcc:/i","/Content-Type:/i","/\n/");
		$name = preg_replace($sonic_what, "", $name);
		$email = preg_replace($sonic_what, "", $email);
		$sonicMessage = preg_replace($sonic_what, "", $sonicMessage);
		if (!$email) {
			$email = $MailToAddress;
		} // end if no email
			$mailHeader = "From: $name <$email>\r\n";
			$mailHeader .= "Reply-To: $name <$email>\r\n";
			$mailHeader .= "Message-ID: <". md5(rand()."".time()) ."@". ereg_replace("www.","",$_SERVER["SERVER_NAME"]) .">\r\n";
			$mailHeader .= "MIME-Version: 1.0\r\n";
			$mailHeader .= "Content-Type: multipart/alternative;";			
			$mailHeader .= " 	boundary=\"----=_NextPart_000_000E_01C5256B.0AEFE730\"\r\n";					
			$mailHeader .= "X-Priority: 3\r\n";
			$mailHeader .= "X-Mailer: PHP/" . phpversion()."\r\n";
			$mailHeader .= "X-MimeOLE: Produced By SonicFog Contact Form Ver $sonic_ver\r\n";
			$mailMessage = "This is a multi-part message in MIME format.\r\n\r\n";
			$mailMessage .= "------=_NextPart_000_000E_01C5256B.0AEFE730\r\n";
			$mailMessage .= "Content-Type: text/plain;   charset=\"ISO-8859-1\"\r\nContent-Transfer-Encoding: quoted-printable\r\n\r\n";			
			$mailMessage .= strip_tags($sonicMessage)."\r\n\r\n";			
			$mailMessage .= "------=_NextPart_000_000E_01C5256B.0AEFE730\r\n";			
			$mailMessage .= "Content-Type: text/html;   charset=\"ISO-8859-1\"\r\nContent-Transfer-Encoding: quoted-printable\r\n\r\n";			
			$mailMessage .= "$sonicMessage\r\n\r\n";			
			$mailMessage .= "------=_NextPart_000_000E_01C5256B.0AEFE730--\r\n";			

			if(!mail($MailToAddress, $MailSubject, $mailMessage,$mailHeader)){
				//everything worked but the mail function
				echo "Error sending e-mail! Please try again later.";
			}else{
				//success message
				?>
 				<table border="0" align="center" cellpadding="0" cellspacing="0">
    			<tr>
      				<td>
				   <br><span class='text'>Hi <? echo $name; ?>,
	  				<p>Thanks for getting in touch.  I'll usually get back to you within 24 hours.
	  				<p>Thank you,
	  				<br>~Steven<br><? echo $CompanyName; ?>
	  				<br><br>Your Message:<p><font color='green'><? echo $message; ?>
					</font>
					</span>
	   				</td>
     			</tr>
	 			</table>
				<?
			}
		}
} //end if step == send
if($_POST["step"] != "send" || $send_email == "no"){
	if($error_type == "fatal"){
		echo "<center><font color=red><b>".$error_message."</b></font></center>";
	}else{
?>
<form method = "post" action = "<? echo $PHP_SELF; ?>">
  <table border="0" align="center" cellpadding="0" cellspacing="0">
    <tr>
      <td><table border="0" align="center" cellpadding="3" cellspacing="1">
	 <?
	if($error_message_name){
		?>
		<tr>
			<td colspan="2">
				<? echo $error_message_name; ?>
			</td>
		</tr>
		<?
	}
	?>
        <tr>
          <td align="right"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">Your name: </font></td>
          <td align="left"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">
            <input name="name" type="text" id="name" value="<? echo $_POST["name"]; ?>">
          </font></td>
        </tr>
	<?
	if($error_message_email){
		?>
		<tr>
			<td colspan="2">
				<? echo $error_message_email; ?>
			</td>
		</tr>
		<?
	}
	?>
        <tr>
          <td align="right"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">Your email:</font>
 </font></td>
          <td align="left"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">
            <input name="email" type="text" id="email" value="<? echo $_POST["email"]; ?>">
<Br><font face="Verdana" size="1">(required for reply.&nbsp; <a href="privacy.shtml" target="privacy" onclick="open ('privacy.shtml', 'privacy', 'height=470,width=415,location=no,menubar=no,toolbar=no,status=no');">read our privacy statement</a>)
          </font></td>
        </tr>

		<?
		//add additional rows with additional input fields here, they will be processed by the script
		?>
        <tr >
          <td align="right"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">Select subject :</font></td>
          <td align="left"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">
		  <select name="subject" id="subject">
		  <?
		  foreach($SubjectArray as $key=>$val){
		  	if($_POST["subject"] == $key){
				echo "<option value='$key' selected>$key</option>";
			}else{
				echo "<option value='$key'>$key</option>";
			}
		  }
		  ?>
          </select>
          </font></td>
        </tr>
	<?
	if($error_message_phone){
		?>
		<tr>
			<td colspan="2">
				<? echo $error_message_phone; ?>
			</td>
		</tr>
		<?
	}
	?>
      
          <td align="right"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">Type your meessage:</font>

</td>
          <td align="left"><font size='1'>use &lt;br&gt; for line breaks and &lt;p&gt; for paragraph breaks.</font><Br>
            <textarea name="message" cols="30" rows="6" id="message"><? echo $message; ?></textarea>
          </td>
        </tr>
		<?
		//generate random numbers
		$random_characters = substr(md5(md5(date("U"))), 0, 5);
		$rc1 = substr($random_characters, 0, 1);
		$rc2 = substr($random_characters, 1, 1);
		$rc3 = substr($random_characters, 2, 1);
		$rc4 = substr($random_characters, 3, 1);
		$rc5 = substr($random_characters, 4, 1);
		
	if($error_message_security){
		?>
		<tr>
			<td colspan="2">
				<? echo $error_message_security; ?>
			</td>
		</tr>
		<?
	}
	?>
		<tr>
          	<td align="left"><font size="1" face="Verdana, Arial, Helvetica, sans-serif">turing test<br>          	<font size="1" face="Verdana, Arial, Helvetica, sans-serif">enter these characters
          	</font></td></tr>
          <TR>	<td align="right">
			<table width=100%>
				<tr>
					<td>
						<table width=100% border="1" cellspacing="0" cellpadding="2">
							<tr bgcolor="#FFFFFF">
								<td align="center"><font color="#0000FF" size="3"><? echo $rc1; ?></font></td>
								<td align="center"><font color="#006633" face="Arial, Helvetica, sans-serif"><? echo $rc2; ?></font></td>
								<td align="center"><font color="#330033" size="3" face="Times New Roman, Times, serif"><? echo $rc3; ?></font></td>
								<td align="center"><font color="#FF0000"><? echo $rc4; ?></font></td>
								<td align="center"><font color="#6E7270" size="4" face="Times New Roman, Times, serif"><? echo $rc5; ?></font></td>
							</tr>
						</table>
					</td>
					<td align="right"><div align="left">
						 &nbsp;&nbsp;&nbsp;<input name="rc" type="text" id="rc" size="10" maxlength="10">
					</div></td>
				</tr>
			</table>
			</td>
   		</tr>
        <tr>
          <td colspan="2" align="center"><p>
								      <input type="submit" name="Submit" value="Submit">
          </td>
        </tr>
      </table>
	  </td>
	</tr>
  </table>
  <input type="hidden" name="step" value="send">
  <input type="hidden" name="rc2" value="<? echo $random_characters; ?>">
</form>
<?
		
	} //end else having to do with fatal errors
} //end if step != send
?>