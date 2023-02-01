build:
	@moonc -t lua/ ./moon/vulpecula && [ -d ./moon/hooks ] && moonc -t lua ./moon/hooks || true

clean:
	@rm -rf ./lua/vulpecula
