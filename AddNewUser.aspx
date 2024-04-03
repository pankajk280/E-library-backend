<%@ Page Title="createUSER" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AddNewUser.aspx.cs" Inherits="Library.AddNewUser" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <script>
       
        $(document).ready(function () {
            $.ajax({
                type: "POST",
                url: "CreateUser.asmx/getData",
                contentType: "application/json",
                success: function (res) {
                    var jsondata = res.d;
                    $("#tbl_data").bootstrapTable({
                        cache: true,
                        data: jsondata,
                        striped: true,
                        pagination: true,
                        pageSize: 10,
                        columns: [
                            {
                                field: 'name',
                                title: 'Name',
                            },
                            {
                                field: 'email',
                                title: 'Email',
                            },
                            {
                                field: 'phone',
                                title: 'Phone',
                            },
                            {
                                field: 'state',
                                title: 'State',
                            },
                            {
                                field: 'city',
                                title: 'City',
                            },
                            {
                                field: 'postal_code',
                                title: 'Postal Code',
                            },
                        ],


                    });
                },
                error: function (err) {
                    console.log(err);
                }
            });

        });


        function btnCreateUser() {
            $(document).ready(function () {
                var name = $("#txtName").val();
                var email = $("#txtEmail").val();
                var phone = $("#txtPhone").val();
                var state = $("#txtState").val();
                var city = $("#txtCity").val();
                var postal = $("#txtPostal").val();
                if (name == "" || email == "" || phone == "" || state == "" || city == "" || postal == "") {
                    alert("Fields can't be empty");
                    return;
                }

                let userData = {
                    name: name,
                    email: email,
                    phone: phone,
                    state: state,
                    city: city,
                    postal_code: postal
                }
                var userDataJson = JSON.stringify(userData);
                $.ajax({
                    type: "POST",
                    url: "CreateUser.asmx/insertData",
                    data: JSON.stringify({ 'userData': userDataJson }),
                    contentType: "application/json",
                    success: function (res) {
                        if (res.d == "SUCCESS") {
                            alert("User Created");
                            location.reload();
                        }
                        console.log(res);
                    },
                    error: function (err) {
                        alert(err.Message);
                    }


                });

            });
        }
    </script>
    <section>
        <div class="container">
            <div class="row mb-4">
                <div class="col-md-10">
                    <div class="card">
                        <div class="card-body">
                            <div class="row">

                                <div class="col-md-4">
                                    <div class="form-group">
                                        <input class="form-control mb-1" id="txtName" placeholder="Name" />
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <input class="form-control mb-1" id="txtEmail" type="email" placeholder="Email Id" />
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <input class="form-control mb-1" id="txtPhone" type="tel" placeholder="Phone Number" />
                                    </div>
                                </div>

                            </div>


                            <div class="row">
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <input class="form-control mb-1" id="txtState" placeholder="State" />
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <input class="form-control mb-1" id="txtCity" placeholder="City" />
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <input class="form-control mb-1" id="txtPostal" placeholder="Postal Code" />
                                    </div>
                                </div>

                            </div>

                        </div>
                    </div>
                </div>
                <div class="col-md-2">
                    <button type="button" class="btn btn-danger" onclick="btnCreateUser()">Create User</button>
                </div>
            </div>
            <div class="row">
                <div class="card col-md-10">
                    <div class="card-body">
                        <div>
                            <h2>
                                Member Details
                            </h2>
                            <table class="table table-striped" id="tbl_data">

                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

</asp:Content>
