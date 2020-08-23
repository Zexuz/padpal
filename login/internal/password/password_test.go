package password

import "testing"

func TestCheckPasswordHash(t *testing.T) {
	type args struct {
		password string
		hash     string
	}
	tests := []struct {
		name string
		args args
		want bool
	}{
		{
			name: "Should return true when checking password (secret)",
			args: struct {
				password string
				hash     string
			}{
				password: "secret",
				hash:     "$2a$14$RLa6vtOTzNelzPeLCTUVN.SdRXGpEpPf/ddrz2rtKwHtsFn/jTvem",
			},
			want: true,
		},
		{
			name: "Should return false when checking password",
			args: struct {
				password string
				hash     string
			}{
				password: "asdq",
				hash:     "$2a$14$RLa6vtOTzNelzPeLCTUVN.SdRXGpEpPf/ddrz2rtKwHtsFn/jTvem",
			},
			want: false,
		},
	}
	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			if got := CheckPasswordHash(tt.args.password, tt.args.hash); got != tt.want {
				t.Errorf("CheckPasswordHash() = %v, want %v", got, tt.want)
			}
		})
	}
}

func TestHashPassword(t *testing.T) {
	type args struct {
		password string
	}
	tests := []struct {
		name    string
		args    args
		wantErr bool
	}{
		{
			name: "should return a hash",
			args: struct {
				password string
			}{
				password: "some Password",
			},
			wantErr: false,
		},
	}
	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			got, err := HashPassword(tt.args.password)
			if (err != nil) != tt.wantErr {
				t.Errorf("HashPassword() error = %v, wantErr %v", err, tt.wantErr)
				return
			}
			if len(got) <= 0 {
				t.Errorf("HashPassword() got = %v, want none empty string", got)
			}
		})
	}
}
