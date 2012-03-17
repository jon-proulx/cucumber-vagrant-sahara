==Test integration of Cucumber and Vagrant + Sahara

[Cucumber](http://cukes.info) is a behaviour specification 
and testing language 

[Vagrant](http://vagrant-up.org) is a tool for building and 
distributing [VirtualBox](http://www.virtualbox.org)virtualized 
development environments

[Sahara](https://github.com/jedi4ever/sahara) is a plugin for managing
sandbox mode in [Vagrant](http://vagrant-up.org) boxes allowing
freezing, rollbacks, and comits

I'm hoping the three togather will be a good base for behaviour driven
development of [Puppet](http://www.puppetlabs.com) and
[Chef](http://www.opscode.com) configuration management
modules/cookbooks, but for now this is just me trying to sort it out

==Caveats

This is all highly specific to my world right now, it may (or many
not) be useful as an example, but it is unlikely to actually run
anywhere but my workstation just now (if it even works there),
especially because of the way I kludged around the next caveat...

shara requires "vagrant", "~>0.9" which conflicts with this, changing
that spec (in the gems/<version>/specifications/sahara-0.0.10.gemspec)
seems to get it all working though.  Vagrant list suggests ">0.9,<1.1"
is probably the right dependency for shara but I'll leave that to the
sahara author.
