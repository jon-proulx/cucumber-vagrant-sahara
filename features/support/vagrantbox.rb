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
