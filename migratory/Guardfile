
guard :minitest do

  watch(%r{^test\/.*\/?(.*)\.rb$})

  watch(%r{^app\/.*\/.*\.(rb|haml)$}) 	{'test'}
  watch(%r{^admin\/.*\/?(.*)\.(rb|haml)$}) 	{'test'}
  watch(%r{^config\/.*\/?(.*)\.(rb)$}) 		{'test'}

end
