IFS=$'\n\t'
set -xeou pipefail

GOCLONE="$HOME/go/src"

# # Install cloud native go tooling
tools=(
 "krew"
 "buildx"
 "docker-compose"
 "faas-cli"
 "gh"
 "helm"
 "istioctl"
 "k9s"
 "kind"
 "kubebuilder"
 "kubectl"
 "kubectx"
 "kubeseal"
 "minikube"
 "packer"
 "yq"
)

for tool in "${tools[@]}"
do
    echo "Installing ${tool}"
    arkade get $tool
done

# Install krew plugins
tools=(
 "advise-psp"
 "allctx"
 "ca-cert"
 "cost"
 "ctx"
 "custom-cols"
 "cyclonus"
 "debug-shell"
 "deprecations"
 "df-pv"
 "direct-csi"
 "doctor"
 "duck"
 "eksporter"
 "emit-event"
 "evict-pod"
 "example"
 "exec-as"
 "exec-cronjob"
 "flame"
 "fleet"
 "flyte"
 "fuzzy"
 "get-all"
 "gke-credentials"
 "graph"
 "grep"
 "hns"
 "iexec"
 "images"
 "ingress-nginx"
 "janitor"
 "konfig"
 "kyverno"
 "mc"
 "ns"
 "operator"
 "service-tree"
 "spy"
 "tmux-exec"
 "tunnel"
 "who-can"
 "whoami"
 "view-secret"
 "tree"
 "ssm-secret"
)

for tool in "${tools[@]}"
do
    echo "Installing ${tool}"
    krew install $tool
done

UPSTREAM_FLYTE_ORG=flyteorg
UPSTREAM_WORKSPCAE=$HOME/workspace/flyteorg

FLYTEORG=$(curl "https://api.github.com/users/flyteorg/repos?per_page=100" | jq -r '.[]|.name')

for name in $FLYTEORG; do
   git clone git@github.com:$UPSTREAM_FLYTE_ORG/$name.git $UPSTREAM_WORKSPCAE/$name
done

# Install Goclone

if [[ -L /usr/local/bin/goclone ]]; then
	if [[ "$(readlink -f /usr/local/bin/goclone)" != "$GOCLONE" ]]; then
		sudo unlink /usr/local/bin/goclone
		sudo ln -s "$GOCLONE" /usr/local/bin/goclone
	fi
fi

GOTOOLS=$HOME/go
mkdir -p "$GOTOOLS"
GOPKGS=(
	# vscode-go tools
	# from https://github.com/Microsoft/vscode-go/blob/master/src/goInstallTools.ts
	github.com/acroca/go-symbols \
	github.com/cweill/gotests/... \
	github.com/derekparker/delve/cmd/dlv \
	github.com/fatih/gomodifytags \
	github.com/golang/lint/golint \
	github.com/haya14busa/goplay/cmd/goplay \
	github.com/josharian/impl \
    github.com/vektra/mockery/cmd/mockery \
    github.com/flyteorg/flytestdlib/cli/pflags \
    github.com/golangci/golangci-lint/cmd/golangci-lint \
    github.com/alvaroloes/enumer \
    github.com/alexellis/arkade \
    github.com/vmware-tanzu/octant/cmd/octant \
	github.com/nsf/gocode \
	github.com/ramya-rao-a/go-outline \
	github.com/rogpeppe/godef \
	github.com/sourcegraph/go-langserver \
	github.com/tylerb/gotype-live \
	github.com/uudashr/gopkgs/cmd/gopkgs \
	github.com/zmb3/gogetdoc \
	golang.org/x/tools/cmd/godoc \
	golang.org/x/tools/cmd/goimports \
	golang.org/x/tools/cmd/gorename \
	golang.org/x/tools/cmd/guru \
	honnef.co/go/tools/... \
	sourcegraph.com/sqs/goreturns \
	github.com/davidrjenni/reftools/cmd/fillstruct \

	# other go dev
	github.com/kardianos/govendor \
	github.com/tools/godep \
	github.com/golang/protobuf/protoc-gen-go \
	github.com/spf13/cobra/cobra \
	github.com/ahmetb/govvv \

	# misc
	github.com/shurcooL/markdownfmt \
	github.com/cpuguy83/go-md2man \
	github.com/rakyll/hey 
	)

GOPATH="$GOTOOLS" go get -u "${GOPKGS[@]}"


# Github Setup
EMAIL_1="code"
EMAIL_2="evalsocket.dev"

set -x

# author
git config --global user.name "Yuvraj"
git config --global user.email "${EMAIL_1}@${EMAIL_2}"

# pull strategy
git config --global pull.ff only

# use https remotes and osxkeychain for creds
git config --global credential.helper osxkeychain
git config --global url.git\@github\.com\:.pushInsteadOf https://github.com/
git config --global gpg.program "gpg"
git config --global commit.gpgsign true  

# diff-so-fancy and its color scheme
git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX"
git config --global color.ui true
git config --global color.diff-highlight.oldNormal "red bold"
git config --global color.diff-highlight.oldHighlight "red bold 52"
git config --global color.diff-highlight.newNormal "green bold"
git config --global color.diff-highlight.newHighlight "green bold 22"
git config --global color.diff.meta "227"
git config --global color.diff.frag "magenta bold"
git config --global color.diff.commit "227 bold"
git config --global color.diff.old "red bold"
git config --global color.diff.new "green bold"
git config --global color.diff.whitespace "red reverse"

# rebase helper
git config --global sequence.editor interactive-rebase-tool

git config --global core.excludesfile ~/.gitignore_global

git config --global init.defaultBranch "main"
