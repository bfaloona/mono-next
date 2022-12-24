import openai
import os
import argparse

argParser = argparse.ArgumentParser()
argParser.add_argument("-f", "--file", help="file to convert")
argParser.add_argument("-p", "--path", help="path to write file")

args = argParser.parse_args()
# print("args=%s" % args)
# print("args.file=%s" % args.file)
# print("args.path=%s" % args.path)

openai.api_key = "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"

def migrate_file(file_path, source_language, target_language, source_version, target_version):
    # Read the contents of the file
    try:
        with open(file_path, "r") as f:
            file_contents = f.read()
    except FileNotFoundError:
        print(f"File not found: {file_path}")
        return

    # Use the OpenAI API to migrate the file contents
    try:
        response = openai.Completion.create(
            engine="text-davinci-003",
            prompt=f"""
            #
            Please migrate file from {source_language} {source_version} to {target_language} {target_version}: {file_contents}
            
            Show me an example of the entire {target_language} version of this file with your migration suggestions implemented.
            
            Please include the following three-line comment at the top of the file:

            #
            # This file was originally written for {source_language} {source_version} by Brandon Faloona, then migrated to {target_language} {target_version} by GPT-3's text-davinci-003 engine, with prompts from Steven Shults. December 2022.
            #

            Also include your own succinct comments above each section of code.
            #
            """,
            max_tokens=2425,
            temperature=0.5,
            top_p=1,
            frequency_penalty=0,
            presence_penalty=0
        )
        return response  # Return the response object if the API call is successful
    except Exception as e:
        # Handle any exceptions that may occur
        print(f"An error occurred: {e}")
        return None  # Return None if an error occurs

# Prompt the user for the file path
# file_path = input("\nEnter the full path, with filename, of the Padrino 0.13\nfile to be migrated to Sinatra 3.0.5: ")
file_path = args.file

# Prompt the user for the directory path
# dir_path = input("\nEnter the full directory path for\nthe migrated file to be written to\n(Omit filename. New filename displayed when ready.): ")
dir_path = args.path

if input (f'Press any key to proceed, or Ctrl-C to cancel\n   Padrino script: {args.file} and \n   Output path: {args.path}'):
    # Print a message while the file is being migrated
    print("\nWorking on it...\n")

    # Call the migrate_file function and assign the returned value to the response variable
    response = migrate_file(file_path, 'Padrino', 'Sinatra', '0.13', '3.0.5')

    # Write the migrated contents to a new file
    if response is not None:
        try:
            base, ext = os.path.splitext(file_path)
            migrated_file_path = f"{dir_path}{os.path.basename(base)}{ext}"
            with open(migrated_file_path, "w") as f:
                f.write(response["choices"][0]["text"])
        except Exception as e:
                print(f"An error occurred while writing to file: {e}")
        else:
                print(f"Migrated file written to {migrated_file_path}")
    else:
        print("An error occurred while migrating the file")
