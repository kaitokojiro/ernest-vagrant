# ernest-vagrant

This repository houses all of the chef code to build a developer environment.
It also houses the vagrant file to spin up a vagrant environment.

If you are making changes to the developer environment, you should use chef's
test kitchen following the steps below. If you are looking to do development on
Ernest's codebase or any of the libraries, you should do a run berksfile and do
a vagrant up.

## Build status

* master:  [![CircleCI](https://circleci.com/gh/ErnestIO/ernest-vagrant/tree/master.svg?style=svg)](https://circleci.com/gh/ErnestIO/ernest-vagrant/tree/master)
* develop: [![CircleCI](https://circleci.com/gh/ErnestIO/ernest-vagrant/tree/develop.svg?style=svg)](https://circleci.com/gh/ErnestIO/ernest-vagrant/tree/develop)

## Prerequisites

Please get setup with vagrant, virtualbox and the chef development kit.

Virtual Box: [https://www.virtualbox.org/](https://www.virtualbox.org/)

Vagrant: [http://www.vagrantup.com/](http://www.vagrantup.com/)

Chef Development Kit: [https://downloads.chef.io/chef-dk/](https://downloads.chef.io/chef-dk/)


## Quickstart

It is best to use regular vagrant for developing ernest microservices and its
libraries. Using vagrant we can halt the box, take snapshots, vagrant
caching, etc.

Inside of the repository, please run berks vendor cookbooks. This will run
berkshelf and pull in all of the cookbook dependencies and place them in a
directory called cookbooks:

```
$ berks vendor cookbooks
```

Now we can simply run vagrant up and access the box via ssh

```
$ vagrant up
```

To login to the vagrant box, use:

```
$ vagrant ssh
```

## Deploying an specific version of Ernest

To version lock a particular ernest release and or its libraries, please modify the chef.json= section of the Vagrantfile. The examples below are actual json, so you will need to convert it to ruby hash syntax

To lock the version of all libraries, please set the following:

```json
{
    "ernest": {
        "version": "0.2.0"
    }
}
```

To override one or more of the components, please use:

```json
{
    "ernest": {
        "version": "0.2.0",
        "versions": {
            "monit": "develop"
        }
    }
}
```

To select a library version, please use:

```json
{
    "ernest": {
        "library-versions": {
            "monit": "develop"
        }
    }
}

```

## Contributing

Please read through our
[contributing guidelines](CONTRIBUTING.md).
Included are directions for opening issues, coding standards, and notes on
development.

Moreover, if your pull request contains patches or features, you must include
relevant unit tests.

## Versioning

For transparency into our release cycle and in striving to maintain backward
compatibility, this project is maintained under
[the Semantic Versioning guidelines](http://semver.org/).

## Copyright and License

Code and documentation copyright since 2015 r3labs.io authors.

Code released under
[the Mozilla Public License Version 2.0](LICENSE).
