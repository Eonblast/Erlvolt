VERSION=0.3.00

all:
	@mkdir -p ebin
	@(cd src; $(MAKE))
	@rm -f touch

# Create doc HTML from source comments
docs:
	@sed -E -f doc/markedoc.sed README.md > doc/readme.edoc
	@sed -E -f doc/markedoc.sed CHANGES.md > doc/changes.edoc
	@erl -noshell -run edoc_run application "'erlvolt'" '"."' '[{def,{vsn,""}},{stylesheet, "erlvolt.css"}]'
	@sed -E -i "" -e "s/<table width=\"100%\" border=\"1\"/<table width=\"100%\" class=index border=\"0\"/" doc/*.html

# Create HTML from Markdown to test README.md appearance
markdown:
	lua etc/markdown.lua README.md

hello: all
	@echo -------------------------------------------------------------------------------
	@echo Erlvolt Hello World
	@echo -------------------------------------------------------------------------------
	@echo This sample works with the catalog and server of voltdb/examples/helloworld.
	@echo Run the server you built with said example and then this, else it will fail.
	erlc hello.erl
	erl -pa ./ebin -s hello run -s init stop -noshell
	@echo -------------------------------------------------------------------------------
	@echo Be aware that it is desired behavior that you will receive multiple
	@echo "VOLTDB ERROR: CONSTRAINT VIOLATION" in case the database was already loaded
	@echo with the language entries, which will be the case if you run this a second 
	@echo time w/o restarting the server.
	@echo -------------------------------------------------------------------------------

test: all
	@echo ------------------------------------------------------------------------o--
	@echo Erlvolt 0.3.00/alpha unit tests
	@echo ---------------------------------------------------------------------------
	@echo -n "" > test.log
	erlc -o ebin etc/erlunit/erlunit.erl
	@cd test; $(MAKE)
	erl -pa ../ebin -s test1 run -s init stop -noshell >  test.log
	erl -pa ../ebin -s test2 run -s init stop -noshell >> test.log
	erl -pa ../ebin -s test3 run -s init stop -noshell >> test.log
	erl -pa ../ebin -s test4 run -s init stop -noshell >> test.log
	@echo ---------------------------------------------------------------------------
	@cat test.log | grep -E "Overall|OK"

clean:
	@(cd src;$(MAKE) clean)
	@rm -f  *.beam
	@rm -f  *.dump
	@rm -f  test.log
	@rm -f  src/erl_crash.dump
	@rm -rf ebin/*.beam
	@rm -f  ebin/erl_crash.dump
	@rm -f  doc/*.html
	@rm -f  doc/readme.edoc
	@rm -f  doc/changes.edoc
	@rm -f  doc/edoc-info
	@rm -f  doc/erlang.png
	@rm -rf test/ct_run*
	@rm -f  test/variables-ct*
	@rm -f  test/*.beam
	@rm -f  test/*.html
