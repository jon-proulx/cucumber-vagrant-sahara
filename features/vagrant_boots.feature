Feature: Booting

I want to cold boot a development VM
freeze state
run Scenario
revert state
loop
shutdown develoment VM

Background:
	  Given a vagrant vm puppetsqueeze64 is running
	  And the vm is frozen

Scenario: access motd
	  When the command cp /etc/motd /vagrant/motd.first is executed on the vm
	  Then the local file motd.first should exist

Scenario: change motd
	  When the command echo FOO > /etc/motd is executed on the vm as root
	  And the command cp /etc/motd /vagrant/motd.second is executed on the vm
	  Then the contents of motd.second should be FOO

Scenario: access motd after change
	  Given I rollback the vm                                   
          When the command cp /etc/motd /vagrant/motd.second is executed on the vm 
	  Then the files motd.first and motd.second should be the same 
