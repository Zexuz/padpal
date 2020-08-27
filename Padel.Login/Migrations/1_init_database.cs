using FluentMigrator;

namespace Padel.Login.Migrations
{
    [Migration(1)]
    public class InitTables : Migration
    {
        public override void Up()
        {
            Create.Table("User")
                .WithColumn("Id").AsInt32().PrimaryKey().Identity().NotNullable().Unique()
                .WithColumn("Username").AsString(50).NotNullable().Unique()
                .WithColumn("PasswordHash").AsString(75).NotNullable()
                .WithColumn("FirstName").AsString(100).NotNullable()
                .WithColumn("LastName").AsString(100).NotNullable()
                .WithColumn("DateOfBirth").AsDate().NotNullable()
                .WithColumn("Email").AsString(300).NotNullable().Unique()
                .WithColumn("IsEmailVerified").AsBoolean().WithDefaultValue(false).NotNullable()
                .WithColumn("Created").AsDateTimeOffset().NotNullable();

            Create.Table("UserAgent")
                .WithColumn("Id").AsInt32().PrimaryKey().Identity().NotNullable().Unique()
                .WithColumn("Name").AsString(300).NotNullable().Unique();

            Create.Table("RefreshToken")
                .WithColumn("Id").AsInt32().PrimaryKey().Identity().NotNullable().Unique()
                .WithColumn("UserId").AsInt32().ForeignKey("user", "id").NotNullable()
                .WithColumn("UserAgent").AsInt32().ForeignKey("useragent", "id").NotNullable()
                .WithColumn("Token").AsString(100).NotNullable()
                .WithColumn("ValidTo").AsDateTimeOffset().NotNullable()
                .WithColumn("Created").AsDateTimeOffset().NotNullable()
                .WithColumn("LastUsed").AsDateTimeOffset().NotNullable()
                .WithColumn("IdDisabled").AsBoolean().WithDefaultValue(false).NotNullable()
                .WithColumn("DisabledWhen").AsDateTimeOffset().Nullable()
                .WithColumn("IssuedFromIp").AsString(17).NotNullable()
                .WithColumn("LastUsedFromIp").AsString(17).NotNullable();
        }

        public override void Down()
        {
            Delete.Table("RefreshToken");
            Delete.Table("UserAgent");
            Delete.Table("User");
        }
    }
}