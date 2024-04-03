<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Forgot_Password.aspx.cs" Inherits="Library.Forgot_Password" %>





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
                                    <h4>Forgot Your Password?</h4>
                                </center>
                                <hr />
                            </div>
                            <div class="row">
                                <div class="col">
                                    <center>
                                        <div class="form-group">
                                            <asp:TextBox CssClass="form-control mb-1" ID="TextBox1" runat="server" placeholder="Enter Email"></asp:TextBox>
                                        </div>


                                        <div class="form-group">
                                            <asp:Button ID="Button1" CssClass="btn btn-primary btn-lg btn-block m-1" runat="server" Text="Reset Password" OnClick="reset_pass" OnClientClick=" return showMODAL();" />
                                        </div>
                                    </center>
                                </div>

                            </div>
                        </div>
                    </div>

                </div>
            </div>

        </div>

        <div id="modalView" class="modal" tabindex="-1">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Modal title</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <p>Modal body text goes here.</p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                        <button type="button" class="btn btn-primary">Save changes</button>
                    </div>
                </div>
            </div>
        </div>
    </section>
</asp:Content>
