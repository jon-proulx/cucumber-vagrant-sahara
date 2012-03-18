Then /^the local file (\S+) should exist$/ do |file|
  unless File.exist?(@mybox.join_cwd(file))
    raise "#{@mybox.join_cwd(file)} does not exist"
  end
end

Then /^the contents of (\S+) should be (.*$)/ do |file,expected_contents|
  found_content=File.read(@mybox.join_cwd(file))
  unless found_content == found_content
    raise "In file #{file}, expected #{expected_content}, found #{found_content}"
  end
end

Then /^the files (\S+) and (\S+) should be the same$/ do |file1, file2|
  unless File.read(@mybox.join_cwd(file1)) == File.read(@mybox.join_cwd(file2))
    raise "#{file1} and #{file2} differ"
  end
end

#this one is starting to feel a bit stretched
Then /^the local file (\S+) (should|should not) contain "([^"]*)"$/ do |file,sense,substring| #"
  if sense == "should"
    unless File.read(@mybox.join_cwd(file)).include?(substring)
      raise "#{file1} does not contain: #{substring}"
    end
  else
    if File.read(@mybox.join_cwd(file)).include?(substring)
    raise "#{file1} should not not contain: #{substring}"
      end
  end
end
