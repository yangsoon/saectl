package version

import (
	"fmt"
	"github.com/spf13/cobra"
	"runtime"
	"saectl/version"
)

func NewVersionCommand() *cobra.Command {
	version := &cobra.Command{
		Use:   "version",
		Short: "Prints saectl build version information",
		Long:  "Prints saectl build version information.",
		Run: func(cmd *cobra.Command, args []string) {
			fmt.Printf(`CLI Version: %v
GitRevision: %v
GolangVersion: %v
`,
				version.SaeCtlVersion,
				version.GitRevision,
				runtime.Version())
		},
	}
	return version
}
