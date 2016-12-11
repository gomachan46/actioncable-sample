# docker_rails_boilerplate

Ruby on Rails 5 works on Docker for development.

# requirements

* docker-compose

# how to use

```
make help
```

# setup

```
make setup
```

prepare containers, gem, migrate and so on.

When this command is executed, it is all settled.

# build server

```
make up
```

build rails server.

After up, see http://localhost:3000

# add gem

```
make gem/install
```

# console

## rails c

```
make console/web
```

run rails console.

## rails db

```
make console/db
```

run mysql console.

# db

## migrate

```
make db/migrate
```

# testing

```
make test
```

run test.

# cleanup/reinstall

## init

initialize containers.

```
make init
```

And execute `make setup`, all will go well.

## reset

```
make reset
```

alias for `make init` and `make setup`.

## gem reset

```
make gem/reset
```

reinstall gems.

## db reset

```
make db/reset
```

