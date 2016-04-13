
def full_url path
  'http://' + PROD_WEBSITE + path
end

def prepend_protocol url
  return url.match(/^https?\:\/\//) ? url : 'http://' + url
end

def monologues_displayed response
  response.body.downcase.split('pdf_file_icon_16x16.png').count - 1
end

module WaitForAjax
  def wait_for_ajax
    Timeout.timeout(Capybara.default_max_wait_time) do
      loop until finished_all_ajax_requests?
    end
  end

  def finished_all_ajax_requests?
    page.evaluate_script('jQuery.active').zero?
  end
end