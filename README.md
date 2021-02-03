# BT

This is a CLI for interacting with the Braintree API.

## Getting started

### Install Crystal

Refer to the [Crystal Install] page for up to date information on how to install Crystal for your specific system.
If you are on a Mac brew is the best option.

``` shsh
brew install crystal
```

### Build Executable

One you have crystal you need to build the project.  You can do so with the provided build tool.

``` shsh
shards build
```

The executable will be in the `bin` directory.

``` sh
./bin/bt help
```

## CLI

### Configuration

Initially `bt` needs to be configured this can be done by executing a command or by running the `config` command directly.

```sh
bt config setup
```

`bt` can also be setup with a profile.  This can be for different merchants of for different environment.

```sh
bt config setup -p sandbox
bt config transaction 123 -p sandbox
```

### Transactions

To get the data for a transaction you can use the find command.

``` sh
bt transaction 27kvpw15
```

### Disputes

#### Create

`bt` can create different types of disputes.  `bt` will create the necessary transaction and even attach evidence automatically if the dispute needs it.

``` sh
# create an open dispute
bt dispute create
# create a won dispute
bt dispute create -S won
# create a lost dispute
bt dispute create -S lost
```

If you need to create a dispute with a specific amount or car expiration date for searching or some other purpose later you can.

``` sh
bt dispute create -a 5050.50 -e "2030/01"
```

`bt` can also create many disputes at once with a flag

``` sh
bt dispute create -S open -n 10
```

#### Evidence

`bt` can upload evidence.  Be aware not all disputes can have evidence uploaded to them and some will return an error if they are not in the right state.

``` sh
bt dispute evidence qq6vgjjbw7hf79jt -t "this totally worked"
```

you can also upload files and remove evidence from a dispute.

#### Search

`bt` has a lot of search functionality and most of it is through flags.  Please check the help for all flags available.  Remember search results can also be streamed into other commands.

``` sh
bt dispute search -a 100,200
```

### Data

`bt` store a lot of data locally.  This saves on trips to the server if you are piping commands together.  This data can grow stale or you might want to look at it for more information then the CLI provides.  You can do basic manipulation of files through `bt`.

To see all the commands you can use help.

``` sh
bt data -h
```

List all the files `bt` has access too.

``` sh
bt data -L
```

To read, write, and delete files you have to use the specific ID of an object.  This is the id not the file name so no extenstion should be used.

``` sh
bt data cy8w4vnq5tndb952 -R
bt data cy8w4vnq5tndb952 -W "My Custom Data"
bt data cy8w4vnq5tndb952 -D
```

Finally if there is a problem you cannot fix you can purge all the data.

``` sh
bt data -P
```

#### Advanced

When commands are not output to the terminal they are streamed in a more machine readable format.  This means you can use most of the linux commandline utility to pipeline data.

This is an example of creating and finding disputes over $100 that are monthly subscribers and uploading your policy for evidence.
note: the Braintree API does not allow for this typr of transaction creating so this is only an example
``` sh
bt dispute create -n 10 | awk '$2>100.00' | bt dispute -X | awk '$22="true"' | bt dispute evidence -f "monthly_subscription_policy.pdf" | bt dispute -F
```

## SDK

This shard also functions as an SDK for building around Braintree

### Installation

1. Add the dependency to your `shard.yml`:

   ```yaml
   dependencies:
     braintree:
       github: wontruefree/braintree
   ```

2. Run `shards install`

### Usage

Most commands that interact with a remote service yield the operation itself and the object.
This means you can condition on the operation or the object before using it.

```crystal
require "braintree"
```

### Transaction

This is an example of the basic Transaction search by id.

```crystal
BTQ::Transaction::Find.exec("123") do |op, transaction|
  if transaction
    puts transaction
  else
    puts "failed message response #{op.try &.response}"
  end
end
```

#### Disputes

```crystal
BTQ::Dispute::Find.exec("123") do |op, dispute|
  if dispute
    puts dispute
  else
    puts "failed message response #{op.try &.response}"
  end
end
```

## Contributors

- [wontruefree](https://github.com/wontruefree) - creator and maintainer
