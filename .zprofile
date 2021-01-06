# Various Environment Vars
export EDITOR=nano
export KOPS_STATE_STORE=s3://kops.infra.core.siteimprove.systems
export KOPS_STATE_S3_ACL=bucket-owner-full-control
export GOPATH=$HOME/code/go
export AWS_PROFILE=default
export FIREFOX_DEVELOPER_BIN=/opt/firefox-dev/firefox
export MOZ_USE_XINPUT2=1

path=(
  $path
  $HOME/code/siteimprove/coreinfra-scripts
  /var/lib/snapd/snap/bin
  $HOME/.local/bin
  $HOME/.cargo/bin
  $GOPATH/bin
  $HOME/.krew/bin
  $HOME/.local/opt/android-sdk/platform-tools
  $HOME/.local/opt/android-sdk/tools
)
