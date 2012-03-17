Feature: Booting

I want to cold boot a development VM
I want changes cause be each scenario to be isolated
(currently constuctor to freeze before and After hook roll back)

Background: have a running system
	  Given a vagrant vm puppetsqueeze64 is running

Scenario: access motd
	  When the command cp /etc/motd /vagrant/motd.first is executed on the vm
	  Then the local file motd.first should exist

Scenario: change motd
	  When the command echo FOO > /etc/motd is executed on the vm as root
	  And the command cp /etc/motd /vagrant/motd.second is executed on the vm
	  Then the contents of motd.second should be FOO

Scenario: access motd after change
          When the command cp /etc/motd /vagrant/motd.third is executed on the vm 
	  Then the files motd.first and motd.third should be the same 
