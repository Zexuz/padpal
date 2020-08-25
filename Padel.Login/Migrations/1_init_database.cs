using FluentMigrator;

namespace Padel.Login.Migrations
{
    [Migration(1)]
    public class InitTables : Migration
    {
        public override void Up()
        {
            Create.Table("user")
                .WithColumn("id").AsInt32().PrimaryKey().Identity().NotNullable().Unique()
                .WithColumn("username").AsString(50).NotNullable().Unique()
                .WithColumn("password_hash").AsString(75).NotNullable()
                .WithColumn("first_name").AsString(100).NotNullable()
                .WithColumn("last_name").AsString(100).NotNullable()
                .WithColumn("date_of_birth").AsDate().NotNullable()
                .WithColumn("email").AsString(300).NotNullable().Unique()
                .WithColumn("is_email_verified").AsBoolean().WithDefaultValue(false).NotNullable()
                .WithColumn("created").AsCustom("TIMESTAMP").NotNullable();

            Create.Table("user_agent")
                .WithColumn("id").AsInt32().PrimaryKey().Identity().NotNullable().Unique()
                .WithColumn("name").AsString(300).NotNullable().Unique();

            Create.Table("refresh_token")
                .WithColumn("id").AsInt32().PrimaryKey().Identity().NotNullable().Unique()
                .WithColumn("user_id").AsInt32().ForeignKey("user", "id").NotNullable()
                .WithColumn("user_agent").AsInt32().ForeignKey("user_agent", "id").NotNullable()
                .WithColumn("token").AsString(100).NotNullable()
                .WithColumn("valid_to").AsCustom("TIMESTAMP").NotNullable()
                .WithColumn("created").AsCustom("TIMESTAMP").NotNullable()
                .WithColumn("last_used").AsCustom("TIMESTAMP").NotNullable()
                .WithColumn("id_disabled").AsBoolean().WithDefaultValue(false).NotNullable()
                .WithColumn("disabled_when").AsCustom("TIMESTAMP").Nullable()
                .WithColumn("issued_from_ip").AsString(17).NotNullable()
                .WithColumn("last_used_from_ip").AsString(17).NotNullable();
        }

        public override void Down()
        {
            Delete.Table("refresh_token");
            Delete.Table("user_agent");
            Delete.Table("user");
        }
    }
}