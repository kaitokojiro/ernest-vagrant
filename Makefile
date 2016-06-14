build: clean
	berks vendor cookbooks

up: build
	vagrant up

provision: build
	vagrant provision

lint:
	rubocop

install:
	bundle install

clean:
	rm -rf cookbooks

deploy: clean
	rm -rf /tmp/.berkshelf
	mkdir /tmp/.berkshelf
	BERKSHELF_PATH=/tmp/.berkshelf berks vendor cookbooks/ -b Berksfile
	ruby solo_gen.rb > solo.json
	chef-solo -c solo.rb --json-attributes solo.json
