build:
	@moonc -t lua/ ./moon/vulpecula && [ -d ./moon/hooks ] && moonc -t lua ./moon/hooks || true

hooks:
	@[ ! -d ./moon/hooks ] && cp -rf ./moon/vulpecula/hooks ./moon/hooks || true

clean:
	@rm -rf ./lua/vulpecula && [ -d ./lua/hooks ] && rm -rf ./lua/hooks || true
