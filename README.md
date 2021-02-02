# braintree

TODO: Write a description here

## Installation

1. Add the dependency to your `shard.yml`:

   ```yaml
   dependencies:
     braintree:
       github: wontruefree/braintree
   ```

2. Run `shards install`

## Usage

```crystal
require "braintree"
```

TODO: Write usage instructions here

## Development

TODO: Write development instructions here

## Contributing

1. Fork it (<https://github.com/your-github-user/braintree/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [your-name-here](https://github.com/your-github-user) - creator and maintainer

./bin/bt dispute search -s open -a 100,200 | awk '$2>123.45' | ./bin/bt dispute -A

# pp(
#   GQL.client(
#     uri: Braintree.graph_host,
#     headers: {
#       "Authorization" => Braintree.auth_token,
#       "Braintree-Version" => "2019-01-01",
#     },
#     tls: false
#   ).query { |q|
#     q.ping
#   }
# )
