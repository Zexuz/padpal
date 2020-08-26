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
                .WithColumn("Created").AsCustom("TIMESTAMP").NotNullable();

            Create.Table("UserAgent")
                .WithColumn("Id").AsInt32().PrimaryKey().Identity().NotNullable().Unique()
                .WithColumn("Name").AsString(300).NotNullable().Unique();

            Create.Table("RefreshToken")
                .WithColumn("Id").AsInt32().PrimaryKey().Identity().NotNullable().Unique()
                .WithColumn("UserId").AsInt32().ForeignKey("user", "id").NotNullable()
                .WithColumn("UserAgent").AsInt32().ForeignKey("useragent", "id").NotNullable()
                .WithColumn("Token").AsString(100).NotNullable()
                .WithColumn("ValidTo").AsCustom("TIMESTAMP").NotNullable()
                .WithColumn("Created").AsCustom("TIMESTAMP").NotNullable()
                .WithColumn("LastUsed").AsCustom("TIMESTAMP").NotNullable()
                .WithColumn("IdDisabled").AsBoolean().WithDefaultValue(false).NotNullable()
                .WithColumn("DisabledWhen").AsCustom("TIMESTAMP").Nullable()
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