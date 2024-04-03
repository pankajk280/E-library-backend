<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="password_reset.aspx.cs" Inherits="Library.forgot_password" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

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
                                            <asp:TextBox CssClass="form-control mb-1" ID="TextBox3" runat="server" TextMode="Email" Enabled="false" placeholder="Email Id"></asp:TextBox>
                                        </div>
                                        <div class="form-group">
                                            <asp:TextBox CssClass="form-control mb-1" ID="TextBox1" runat="server" TextMode="Password" placeholder="New Password"></asp:TextBox>
                                        </div>
                                        <div class="form-group">
                                            <asp:TextBox CssClass="form-control mb-1" ID="TextBox2" runat="server" TextMode="Password" placeholder="Confirm Password"></asp:TextBox>
                                        </div>

                                        <div class="form-group">
                                            <asp:Button ID="Button1" CssClass="btn btn-primary btn-lg btn-block m-1" runat="server" Text="Reset Password" OnClick="btn_resetPass" />
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
