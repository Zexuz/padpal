using System;
using System.IO;
using System.Threading.Tasks;
using FakeItEasy;
using Padel.Identity.Services;
using Xunit;

namespace Padel.Identity.Test
{
    public class KeyLoaderTest
    {
        private readonly IFileService _fakeFileService;
        private readonly string       _publicKeyPath;
        private readonly string       _privateKeyPath;
        private readonly KeyLoader    _sut;

        private const string ExpectedPublicKey =
            @"MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAs4PEOOF/6vSwCk4Mywz6IgY+TxkPxjl/GDmRmEfMXICH9bdq17wcWjNwDNAZmOBqx8Xb2MEAGnHJE8OEDXE8QruTkXMq7LdfpNaavDdDAhGAd12qvkTl0g/HBMCzWOfmLjInxleZw5y9qAMN0E6in+QZ9yNxocvrqSuF5EX0b1FI634PYa9HqdX75oDSnKR2y2Qa97ubGbqXwHBFxQHTCBogOj62/2lhmRxSOhIofs8HHcMkU5lsotsMvgokVEVR2L1FMWaEfve8B51z8cj46lD+8F/jN3XDd5QPyIEG0c6v5kXdEOFCLRnoxuURHx3nd/KaO9exOajn4XeBowdjzQIDAQAB";

        private const string ExpectedPrivateKey =
            @"MIIEpAIBAAKCAQEAs4PEOOF/6vSwCk4Mywz6IgY+TxkPxjl/GDmRmEfMXICH9bdq17wcWjNwDNAZmOBqx8Xb2MEAGnHJE8OEDXE8QruTkXMq7LdfpNaavDdDAhGAd12qvkTl0g/HBMCzWOfmLjInxleZw5y9qAMN0E6in+QZ9yNxocvrqSuF5EX0b1FI634PYa9HqdX75oDSnKR2y2Qa97ubGbqXwHBFxQHTCBogOj62/2lhmRxSOhIofs8HHcMkU5lsotsMvgokVEVR2L1FMWaEfve8B51z8cj46lD+8F/jN3XDd5QPyIEG0c6v5kXdEOFCLRnoxuURHx3nd/KaO9exOajn4XeBowdjzQIDAQABAoIBAQCwk1vf12/L3QOMH1nWIN2puhpwE2bAxK2PVpEwCO+rzYHu4IvnyNDaqN3+vHNxPM3L04N8odtIJ8Rx/E9YKZnsyjVNTMtcLMOXkMCDgpgW4MBMqYXZwkuNZJeOxT2kpfZ0WkFlh6VoFDU5nkdoLvEn9WbVAbg0PjGAJZ99+pGFK/hqAOS2rza1WM7isUtLuQu/WZc2kiaQ2kvkFDChHsIYeBGbKVa95XZEW8sGBDZJMjfVpc1W5Bm5eV8OolljmyrF+2f8H8u62NidSoeorCkNsd4EyYlhNDQxKqQ+2HxjxjldCvqdrjXWgD1mJXFMkO+95UydfeFu9xsdAfdcBULBAoGBAOdRepNbeOPI6eta30XVZzmyOkDpbK9N9hztODXsDF8vVEiLEIXlugTVKKosZe58zr2F3sC2H19Ro/ZfecGztaJZghkKDlEflwxw59hLmnXOGgn8z12Lt/FzCcOnMecFD98o6h2/9XFDgfqv8AZO/e2DX7yJY/FtMq/f7aOLZ8N/AoGBAMarQmS9IGp39QHCNewZYNrFBCWagJ7GPHR6Q3r0J/Qan2y8GVfk5h3i0t9jlLtSFyhUvY4CTtfDYhHTiMrO3QTz7amdLdovQp431SrapmdudGqZkBWsAVddkD+jg6BrEzT95akrhmSvr1xOGRpfRSlcP/gOCMDT7O8L6DTEl06zAoGAMzmO7Gz4Q3EtpAn2oa9VcahvUAqhH90i4FsD9KT2RGnlvz7UhOJPpFxT6gN0+zA2VC/+GSz7m48nwRp5ixSx52bs8YCRlRNqzr1+Ch8L8ISYrZeHkE6tiFGSWvp+iYtMbX3RAo+M2e06Lnqhq7P4dY1/OPAv6rnk3J+5L1tiuh8CgYA5wRewCXse+Hh1ZmwektIhRx0JgXzaq25vvgtX9xqWUBcAmT4U2yo6jfIXlu9p9VdeFiR04B7jgp1D6Wbe7nw6MF9q65Kk1xBaxohlyOKPNwEI7FOCuVo6d6yzk2l0fSw8P4NARrLvGlO0Vc/eZsvIVlUSW6IXzIQYijGbBXunGQKBgQCHp5dY4x28TdX4DLAugBbT+EZSW9f6HUSDpUaQvTnVjT0JsOJ46Xvro6oyiiAnMXkbjr2oYD95Phe1sGQ72fYlOUKRmm6v2q/z1FL/cWsfA1iIn0smbr2Mp8CFWAbFnLrwdE/1XlFCYYnJtgG57ZUPIswCto9l+QAdjMN6oc+jZQ==";

        public KeyLoaderTest()
        {
            _fakeFileService = A.Fake<IFileService>();

            var basePath = Path.Combine(Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData), "padel");
            _publicKeyPath = Path.Combine(basePath, "public.txt");
            _privateKeyPath = Path.Combine(basePath, "private.txt");

            _sut = new KeyLoader(_fakeFileService);
        }

        [Fact]
        public async Task Should_load_keys_from_files_if_files_exists()
        {
            A.CallTo(() => _fakeFileService.DoesFileExist(A<string>.That.Matches(s => s == _publicKeyPath))).Returns(true);
            A.CallTo(() => _fakeFileService.DoesFileExist(A<string>.That.Matches(s => s == _privateKeyPath))).Returns(true);
            A.CallTo(() => _fakeFileService.ReadAllText(A<string>.That.Matches(s => s   == _publicKeyPath))).Returns(ExpectedPublicKey);
            A.CallTo(() => _fakeFileService.ReadAllText(A<string>.That.Matches(s => s   == _privateKeyPath))).Returns(ExpectedPrivateKey);

            var (publicKey, privateKey) = await _sut.Load();

            Assert.Equal(Convert.FromBase64String(ExpectedPublicKey), publicKey.ExportSubjectPublicKeyInfo());
            Assert.Equal(Convert.FromBase64String(ExpectedPrivateKey), privateKey.ExportRSAPrivateKey());

            A.CallTo(() => _fakeFileService.ReadAllText(A<string>.That.Matches(s => s == _publicKeyPath))).MustHaveHappenedOnceExactly();
            A.CallTo(() => _fakeFileService.ReadAllText(A<string>.That.Matches(s => s == _privateKeyPath))).MustHaveHappenedOnceExactly();
            A.CallTo(() => _fakeFileService.WriteAllText(A<string>._, A<string>._)).MustNotHaveHappened();
        }

        [Fact]
        public async Task Should_overwrite_file_if_only_one_exists()
        {
            A.CallTo(() => _fakeFileService.DoesFileExist(A<string>.That.Matches(s => s == _publicKeyPath))).Returns(true);
            A.CallTo(() => _fakeFileService.DoesFileExist(A<string>.That.Matches(s => s == _privateKeyPath))).Returns(false);
            A.CallTo(() => _fakeFileService.ReadAllText(A<string>.That.Matches(s => s   == _publicKeyPath))).Returns(ExpectedPublicKey);
            A.CallTo(() => _fakeFileService.ReadAllText(A<string>.That.Matches(s => s   == _privateKeyPath))).Returns(ExpectedPrivateKey);

            var (publicKey, privateKey) = await _sut.Load();

            Assert.Equal(Convert.FromBase64String(ExpectedPublicKey), publicKey.ExportSubjectPublicKeyInfo());
            Assert.Equal(Convert.FromBase64String(ExpectedPrivateKey), privateKey.ExportRSAPrivateKey());

            A.CallTo(() => _fakeFileService.ReadAllText(A<string>.That.Matches(s => s == _publicKeyPath))).MustHaveHappenedOnceExactly();
            A.CallTo(() => _fakeFileService.ReadAllText(A<string>.That.Matches(s => s == _privateKeyPath))).MustHaveHappenedOnceExactly();
            A.CallTo(() => _fakeFileService.WriteAllText(A<string>._, A<string>._)).MustHaveHappenedTwiceExactly();
        }
    }
}