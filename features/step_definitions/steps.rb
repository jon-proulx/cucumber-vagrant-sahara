require 'rubygems'
require 'vagrant'
require 'sahara'

class VagrantBox
  attr_reader :env, :cwd
  def initialize(basebox)
    #brittle code...
    @name=basebox
    @cwd=File.join("/scratch/vagrant-boxen",@name)
    @env=Vagrant::Environment.new(:cwd =>@cwd)

    Dir.mkdir(@cwd) unless File::directory?(@cwd) 
    File.open(File.join(@cwd,"Vagrantfile"),"w+") do |conf_file|                      
      conf_file.write """Vagrant::Config.run do |config|
  config.vm.box = \'#{@name}\'
end                                                                            """
    end
  end

  def up
    # We might be created but suspended too, need to handle more cases 
    if @env.primary_vm.state != :running
      print "Booting #{@name} patience..."
      @env.cli("up")
      puts "done"
    end
    raise "Failed to start vm #{@name} " if @env.primary_vm.state != :running
  end
  
  def freeze
    @env.cli("sandbox","on") 
  end

  def rollback
    @env.cli("sandbox","rollback")
  end
end

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

