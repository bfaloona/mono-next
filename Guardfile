
guard :minitest do

  non_prod_test_dirs = ["test/unit", "test/models", "test/integration"]

  watch(%r{^test\/.*(?<!prod)\/?(.*)\.rb$})    {non_prod_test_dirs}
  watch(%r{^app\/.*\/?(.*)\.(rb|haml)$})    {non_prod_test_dirs}
  watch(%r{^admin\/.*\/?(.*)\.(rb|haml)$})    {non_prod_test_dirs}
  watch(%r{^config\/.*\/?(.*)\.(rb)$})    {non_prod_test_dirs}
  watch(%r{^lib\/.*\/?(.*)\.(rb)$})    {non_prod_test_dirs}

  watch(%r{^test\/prod\/(.*)_test\.rb$})      {"test/prod"}

end
