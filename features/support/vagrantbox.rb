require 'rubygems'
require 'vagrant'
require 'sahara'

class VagrantBox
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
    end
    raise "Failed to start vm #{@name} " if @env.primary_vm.state != :running
    puts "freezing mv state..."
    self.freeze
    puts "done"
  end
  
########################################################################
##Sahara sandbox features don't work from method calls
##The seem to think the environment isn't running
##but the work from the shell (sahara doesn't claim
##support for 1.0 vagrant only ~>0.9, I'm forcing it) 
  def freeze
    #@env.cli("sandbox","on") 
    `cd #{@cwd} ; /var/lib/gems/1.8/bin/vagrant sandbox on`
  end

  def rollback
    #@env.cli("sandbox","rollback")
    `cd #{@cwd} ; /var/lib/gems/1.8/bin/vagrant sandbox rollback`
  end
########################################################################
  def execute(cmd)
    @env.primary_vm.channel.execute(cmd)
  end

  def sudo(cmd)
    @env.primary_vm.channel.sudo(cmd)
  end

  def join_cwd(file)
    File.join(@cwd,file)
  end
end
