using System;
using System.Collections.Generic;
using System.Linq;
using FakeItEasy;
using FakeItEasy.Sdk;

namespace Padel.Test.Core
{
    public static class TestHelper
    {
        private static readonly Random _random = new Random();

        public const string Letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
        public const string Digits  = "123456789";

        public static string RandomEmail()
        {
            return RandomString(10, Letters) + "@gmail.com";
        }

        public static string RandomPassword()
        {
            return RandomString(10);
        }


        public static string RandomString(int length, string chars = Letters + Digits)
        {
            return new string(Enumerable.Repeat(chars, length).Select(s => s[_random.Next(s.Length)]).ToArray());
        }
        
        public static T ActivateWithFakes<T>(params object[] overrides)
        {
            var dict = new Dictionary<Type, object>();

            foreach (var o in overrides)
            {
                var manager = Fake.GetFakeManager(o);
                dict[manager.FakeObjectType] = o;
            }

            var myType = typeof(T);
            var constructorInfos = myType.GetConstructors();
            if (constructorInfos.Length != 1)
            {
                throw new Exception("Type must have only one ctor");
            }

            var args = new List<object>();

            var ctor = constructorInfos[0];
            var parameters = ctor.GetParameters();
            foreach (var parameterInfo in parameters)
            {
                var paramType = parameterInfo.ParameterType;
                if (dict.ContainsKey(paramType))
                {
                    args.Add(dict[paramType]);
                    continue;
                }

                args.Add(Create.Fake(paramType));
            }

            return (T) Activator.CreateInstance(myType, args.ToArray());
        }
    }
}