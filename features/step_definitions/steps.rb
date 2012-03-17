Given /^a vagrant vm (\w+) (?:is running|is up|)$/ do |box|
  @mybox=VagrantBox.new(box)
  @mybox.up
end

Given /^I freeze the vm$/ do
  @mybox.env.cli("sandbox","on")
end

Given /^I rollback the vm$/ do
  @mybox.env.cli("sandbox","rollback")
end

When /^the command (.*) is executed on the vm$/ do |cmd|
  @mybox.env.primary_vm.channel.execute(cmd)
end

Then /^the local file (\w+\.*\w*) should exist$/ do |file|
  unless File.exist?(File.join(@mybox.cwd,file))
    raise "#{File.join(@mybox.cwd,file)} does not exist"
  end
end

When /^the vm executes echo FOO > \/etc\/motd$/ do
  pending # express the regexp above with the code you wish you had
end

When /^the command cp \/etc\/motd \/vagrant\/motd\.second is executed on the vm$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^the contents of motd\.second should be FOO$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^the files motd\.first and motd\.second should be the same$/ do
  pending # express the regexp above with the code you wish you had
end

