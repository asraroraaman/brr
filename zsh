RPROMPT='%{$fg[blue]%}($ZSH_KUBECTL_PROMPT)%{$reset_color%}'
SPACESHIP_TIME_SHOW="true"
# Make prompt like pure prompt
SPACESHIP_CHAR_SYMBOL="❯"
SPACESHIP_CHAR_SUFFIX=" "
SPACESHIP_PACKAGE_SHOW="false"
SPACESHIP_DIR_COLOR="blue"

# removes 'on'
SPACESHIP_GIT_PREFIX=""

# remove git symbol
SPACESHIP_GIT_BRANCH_PREFIX="branch:"

SPACESHIP_GIT_BRANCH_COLOR="white"
SPACESHIP_GIT_STATUS_COLOR="red"
SPACESHIP_GIT_STATUS_PREFIX=" ["
SPACESHIP_GIT_STATUS_SUFFIX="]"
SPACESHIP_KUBECTL_SHOW="true"
SPACESHIP_KUBECTL_VERSION_SHOW="false"
SPACESHIP_KUBECONTEXT_SHOW="true"
SPACESHIP_KUBECONTEXT_NAMESPACE_SHOW="true"
SPACESHIP_KUBECONTEXT_COLOR="061"
SPACESHIP_KUBECTL_COLOR="white"
# SPACESHIP_KUBECTL_SYMBOL="☸️  "
SPACESHIP_KUBECTL_SYMBOL=""
SPACESHIP_KUBECTL_SUFFIX=""
SPACESHIP_KUBECTL_PREFIX="k8s:"
SPACESHIP_KUBECTL_CONTEXT_COLOR="red"
SPACESHIP_KUBECTL_CONTEXT_COLOR_GROUPS=(
  # red if namespace is "kube-system"
  red    '\(kube-system)$'

  # else, green if "dev-01" is anywhere in the context or namespace
  green  qa

  red  prod

  # else, red if context name ends with ".k8s.local" _and_ namespace is "system"
  red    '\.k8s\.local \(system)$'

  # else, yellow if the entire content is "test-" followed by digits, and no namespace is displayed
  yellow '^test-[0-9]+$'
)
