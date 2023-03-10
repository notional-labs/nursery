package wasm_test

import (
	"testing"

	tmproto "github.com/cometbft/cometbft/proto/tendermint/types"
	sdk "github.com/cosmos/cosmos-sdk/types"
	"github.com/cosmos/cosmos-sdk/types/module"
	upgradetypes "github.com/cosmos/cosmos-sdk/x/upgrade/types"
	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/require"

	"github.com/CosmWasm/wasmd/app"
	"github.com/CosmWasm/wasmd/x/wasm"
)

func TestModuleMigrations(t *testing.T) {
	NurseryApp := app.Setup(t)
	ctx := NurseryApp.BaseApp.NewContext(false, tmproto.Header{})
	upgradeHandler := func(ctx sdk.Context, plan upgradetypes.Plan, fromVM module.VersionMap) (module.VersionMap, error) { //nolint:unparam
		return NurseryApp.ModuleManager.RunMigrations(ctx, NurseryApp.Configurator(), fromVM)
	}
	fromVM := NurseryApp.UpgradeKeeper.GetModuleVersionMap(ctx)
	fromVM[wasm.ModuleName] = 1                                     // start with initial version
	upgradeHandler(ctx, upgradetypes.Plan{Name: "testing"}, fromVM) //nolint:errcheck
	// when
	gotVM, err := NurseryApp.ModuleManager.RunMigrations(ctx, NurseryApp.Configurator(), fromVM)
	// then
	require.NoError(t, err)
	assert.Equal(t, uint64(2), gotVM[wasm.ModuleName])
}
