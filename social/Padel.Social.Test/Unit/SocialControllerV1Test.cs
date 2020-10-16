// using System.Threading.Tasks;
// using FakeItEasy;
// using Grpc.Core;
// using Padel.Proto.Social.V1;
// using Padel.Social.Runner.Controllers;
// using Padel.Social.Services.Interface;
// using Padel.Test.Core;
// using Xunit;
//
// namespace Padel.Social.Test.Unit
// {
//     public class SocialControllerV1Test : TestControllerBase
//     {
//         private readonly SocialControllerV1    _sut;
//         private readonly IProfileSearchService _fakeProfileSearchService;
//         private          ServerCallContext     _ctx;
//
//         public SocialControllerV1Test()
//         {
//             _fakeProfileSearchService = A.Fake<IProfileSearchService>();
//             _ctx = CreateServerCallContextWithUserId(1337);
//
//             _sut = TestHelper.ActivateWithFakes<SocialControllerV1>(_fakeProfileSearchService);
//         }
//        
//     }
// }