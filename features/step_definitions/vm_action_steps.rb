Given /^a vagrant vm (\w+) (?:is running|is up|)$/ do |box|
  @mybox=VagrantBox.new(box)
  @mybox.up
end

Given /^(?:I freeze the vm|the vm is frozen)$/ do
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

