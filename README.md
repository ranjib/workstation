### Installation
- Install and configure ruby & bundler
- Clone workstation repo, cd into it
- Install deps
```sh
bundle install --path .bundle
```
- Build package
```sh
bundle exec rake package
```
- Bootstrap a workstation
```sh
bundle exec ruby bin/boot.rb workstation_0.0.1_amd64.deb --host <IP> -p
```
