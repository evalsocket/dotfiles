// +build tools

package tools

import (
	_ "github.com/alexellis/arkade"
	_ "github.com/alvaroloes/enumer"
	_ "github.com/flyteorg/flytestdlib/cli/pflags"
	_ "github.com/golangci/golangci-lint/cmd/golangci-lint"
	_ "github.com/vektra/mockery/cmd/mockery"
	_ "github.com/vmware-tanzu/octant/cmd/octant"
)
