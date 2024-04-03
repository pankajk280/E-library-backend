
<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" EnableSessionState="True" Inherits="Library.Login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <script>

        function btn_Login() {
            $(document).ready(function () {
                var email = $("#txtemail").val();
                var pass = $("#txtpass").val();
                if (email == "" || pass == "") {
                    alert("Fields can't be empty");
                    return;
                }

                let userData = {
                    email: email,
                    pass: pass
                };

                var userDataJson = JSON.stringify(userData);

                $.ajax({
                    type: "POST",
                    timeout: 2000,
                    cache: false,
                    async:false,
                    url: "CreateUser.asmx/Login",
                    data: JSON.stringify({ 'userData': userDataJson }),
                    contentType: "application/json",
                    success: function (res) {
                        console.log(res);
                        if (res.d.status == 100) {
                            alert("Successfully logged in!!");
                            var url = new URLSearchParams(window.location.search);
                            url.set('EMAIL', res.d.email);
                            url.set('ID', res.d.status);
                            var newUrl = "ResetPassword.aspx?" + url.toString();
                            window.location.href = newUrl;
                        }
                        else if (res.d.status == 200) {
                            alert("Successfully logged in!!");


                            window.location.href = "Default.aspx";
                        } else {
                            alert("Unauthorized Access!!");
                        }
                    },
                    error: function (err) {
                        alert(err);
                    }
                });
            });
        }    


        function btnForgotPassword() {
            window.location.href = "Forgot_Password.aspx";

        }

    </script>

    <section>
        <div class="container">
            <div class="row">
                <div class="col-md-6 mx-auto">
                    <div class="card">
                        <div class="card-body">
                            <div class="row">
                                <center>
                                    <img src="Images/generaluser.png" width="100px" />
                                    <h5>Member Login</h5>
                                </center>
                                <hr />
                            </div>
                            <div class="row">
                                <div class="col">
                                    <center>
                                        <div class="form-group">
                                            <input class="form-control mb-1" id="txtemail" placeholder="Member Email" />
                                        </div>
                                        <div class="form-group">
                                            <input class="form-control mb-2" id="txtpass" type="password" placeholder="Password" />
                                        </div>

                                        <div class="form-group">
                                            <button class="btn btn-success" onclick="btn_Login(); return false">Login</button>
                                        </div>
                                        <div class="form-group">
                                            <a class="text-decoration-none m-1" style="cursor:pointer" onclick="btnForgotPassword()"  >Forgot Password?</a>
                                        </div>
                                    </center>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</asp:Content>
