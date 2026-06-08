package main

import (
	"io/ioutil"
	"testing"

	"github.com/stretchr/testify/assert"
)

func TestRendering(t *testing.T) {
	assert := assert.New(t)
	tests := map[string]struct {
		dataPath string
		wantPath string
	}{
		"simple": {
			dataPath: "testdata/test.yaml",
			wantPath: "testdata/output.txt"},
	}

	for name, tc := range tests {
		t.Run(name, func(t *testing.T) {
			data, err := loadConfigData(tc.dataPath)
			assert.Equal(nil, err)
			want, err := ioutil.ReadFile(tc.wantPath)
			assert.Equal(nil, err)
			s, err := render("../../config/offlineimap/config.tmpl", data)
			assert.Equal(nil, err)
			assert.Equal(string(want), s)

		})
	}
}
