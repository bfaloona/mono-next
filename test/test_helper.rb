
def full_url path
  'http://' + PROD_WEBSITE + path
end

def prepend_protocol url
  return url.match(/^https?\:\/\//) ? url : 'http://' + url
end

def monologues_displayed response
  response.body.downcase.split('firstline').count - 1
end
