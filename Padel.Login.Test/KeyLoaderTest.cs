using System;
using System.IO;
using System.Threading.Tasks;
using FakeItEasy;
using Xunit;

namespace Padel.Login.Test
{
    public class KeyLoaderTest
    {
        [Fact]
        public async Task Should_load_keys_from_files_if_files_exists()
        {
            var fakeFileService = A.Fake<IFileService>();

            var basePath = Path.Combine(Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData), "padel");
            var publicKeyPath = Path.Combine(basePath, "public.txt");
            var privateKeyPath = Path.Combine(basePath, "private.txt");

            A.CallTo(() => fakeFileService.DoesFileExist(A<string>.That.Matches(s => s == publicKeyPath))).Returns(true);
            A.CallTo(() => fakeFileService.DoesFileExist(A<string>.That.Matches(s => s == privateKeyPath))).Returns(true);
            A.CallTo(() => fakeFileService.ReadAllLines(A<string>.That.Matches(s => s  == publicKeyPath))).Returns("hello");
            A.CallTo(() => fakeFileService.ReadAllLines(A<string>.That.Matches(s => s  == privateKeyPath))).Returns("world");

            var keyfileLoader = new KeyLoader(fakeFileService);

            var (publicKey, privateKey) = await keyfileLoader.Load();

            Assert.Equal("hello", publicKey);
            Assert.Equal("world", privateKey);

            A.CallTo(() => fakeFileService.ReadAllLines(A<string>.That.Matches(s => s == publicKeyPath))).MustHaveHappenedOnceExactly();
            A.CallTo(() => fakeFileService.ReadAllLines(A<string>.That.Matches(s => s == privateKeyPath))).MustHaveHappenedOnceExactly();
            A.CallTo(() => fakeFileService.WriteAllBytesAsync(A<string>._, A<byte[]>._)).MustNotHaveHappened();
        }

        [Fact]
        public async Task Should_overwrite_file_if_only_one_exists()
        {
            var fakeFileService = A.Fake<IFileService>();

            var basePath = Path.Combine(Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData), "padel");
            var publicKeyPath = Path.Combine(basePath, "public.txt");
            var privateKeyPath = Path.Combine(basePath, "private.txt");

            A.CallTo(() => fakeFileService.DoesFileExist(A<string>.That.Matches(s => s == publicKeyPath))).Returns(true);
            A.CallTo(() => fakeFileService.DoesFileExist(A<string>.That.Matches(s => s == privateKeyPath))).Returns(false);
            A.CallTo(() => fakeFileService.ReadAllLines(A<string>.That.Matches(s => s  == publicKeyPath))).Returns("someNewKeys");
            A.CallTo(() => fakeFileService.ReadAllLines(A<string>.That.Matches(s => s  == privateKeyPath))).Returns("privateKey");

            var keyfileLoader = new KeyLoader(fakeFileService);

            var (publicKey, privateKey) = await keyfileLoader.Load();

            Assert.Equal("someNewKeys", publicKey);
            Assert.Equal("privateKey", privateKey);

            A.CallTo(() => fakeFileService.ReadAllLines(A<string>.That.Matches(s => s == publicKeyPath))).MustHaveHappenedOnceExactly();
            A.CallTo(() => fakeFileService.ReadAllLines(A<string>.That.Matches(s => s == privateKeyPath))).MustHaveHappenedOnceExactly();
            A.CallTo(() => fakeFileService.WriteAllBytesAsync(A<string>._, A<byte[]>._)).MustHaveHappenedTwiceExactly();
        }
    }
}