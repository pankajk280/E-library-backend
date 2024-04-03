<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ResetPassword.aspx.cs" Inherits="Library.ResetPassword" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <script>
        var urlParams = new URLSearchParams(window.location.search);
        var email = urlParams.get('EMAIL');
        var id = urlParams.get('ID');
        
        window.onload =  ()=> {
            $("#txtemail").val(email);
        }

        function btn_resetPass() {
            var pass = $("#txtpass").val();
            var cnf_pass = $("#txtcnfPass").val();

            if (pass == "" || cnf_pass == "") {
                alert("Fields can't be empty");
                return;
            }

            if (pass != cnf_pass) {
                alert("Passwords should be same");
                return;
            }


            $(document).ready(function () {
                $.ajax({
                    type: "POST",
                    url: "CreateUser.asmx/reset_password",
                    data: JSON.stringify({ password: pass, email_id: email }),
                    contentType: "application/json",
                    success: function (res) {
                        if (res.d == "SAME PASSWORD") {
                            alert("New Password can not be same as previous password");
                        }
                        else {
                            alert("Password CHANGED SUCCESSFULY!!");
                            window.location.href = "Login.aspx";
                        }
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
            <div class="row">
                <div class="col-md-6 mx-auto">
                    <div class="card">
                        <div class="card-body">
                            <div class="row">
                                <center>
                                    <img src="Images/forgot_password.png" width="100px" class="rounded" />
                                    <h4>Password Reset</h4>
                                </center>
                                <hr />
                            </div>
                            <div class="row">
                                <div class="col">
                                    <center>


                                        <div class="form-group">
                                            <input class="form-control mb-1" id="txtemail" disabled placeholder="Email Id">
                                        </div>
                                        <div class="form-group">
                                            <input class="form-control mb-1" type="password" id="txtpass" placeholder="New Password">
                                        </div>
                                        <div class="form-group">
                                            <input class="form-control mb-1" type="password" id="txtcnfPass" placeholder="Confirm Password">
                                        </div>
                                        <div class="form-group">
                                            <button class="btn btn-primary btn-lg btn-block m-1" onclick="btn_resetPass(); return false">Reset Password</button>
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
