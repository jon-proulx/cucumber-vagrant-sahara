Feature: Booting

I want to cold boot a development VM
freeze state
run Scenario
revert state
loop
shutdown develoment VM

Scenario: access motd
	  Given a vagrant vm puppetsqueeze64 is running
	  When the command cp /etc/motd /vagrant/motd.first is executed on the vm
	  Then the local file motd.first should exist

Scenario: change motd
  	  Given a vagrant vm puppetsqueeze64 is running
	  And I freeze the vm
	  When the command echo FOO > /etc/motd is executed on the vm
	  And the command cp /etc/motd /vagrant/motd.second is executed on the vm
	  Then the contents of motd.second should be FOO

Scenario: access motd after change
          Given a vagrant vm puppetsqueeze64 is running
	  And I rollback the vm                                   
          When the command cp /etc/motd /vagrant/motd.second is executed on the vm 
	  Then the files motd.first and motd.second should be the same 
