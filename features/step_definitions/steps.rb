Given /^a vagrant vm (\w+) (?:is running|is up|)$/ do |box|
  @mybox=VagrantBox.new(box)
  @mybox.up
end

Given /^I freeze the vm$/ do
  @mybox.freeze
end

Given /^I rollback the vm$/ do
  @mybox.rollback
end

When /^the command (.*) is executed on the vm$/ do |cmd|
  @mybox.execute(cmd)
end

When /^the command (.*) is executed on the vm as root$/ do |cmd|
  @mybox.sudo(cmd)
end

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

