<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="user_signup.aspx.cs" Inherits="Library.user_signup" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <script>
        function btn_validateAddress() {
            var addressLine_1 = $("#txtAddressLine1").val().toUpperCase();
            var addressLine_2 = $("#txtAddressLine2").val().toUpperCase();
            var City = $("#txtCity").val().toUpperCase();
            var State = $("#txtState").val().toUpperCase();
            var Country = $("#txtCountry").val().toUpperCase();
            var PostalCode = $("#txtPostalCode").val().toUpperCase()

            var originalAddress = "";
            if (addressLine_1 != "") {c
                originalAddress += addressLine_1 + "\n";
            }
            if (addressLine_2 != "") {
                originalAddress += addressLine_2 + "\n";
            }
            if (City != "") {
                originalAddress += City + ", ";
            }
            if (State != "") {
                originalAddress += State + "\n";
            }
            if (Country != "") {
                originalAddress += Country + "\n";
            }
            if (PostalCode != "") {
                originalAddress += PostalCode;
            }

            var objAddress = {
                addressLine1: addressLine_1,
                addressLine2: addressLine_2,
                city: City,
                state: State,
                country: Country,
                postalCode: PostalCode
            };

            var jsonAddressData = JSON.stringify(objAddress);

            $.ajax({
                type: "POST",
                url: "CreateUser.asmx/validateAddress",
                async: false,
                cache: false,
                data: JSON.stringify({ 'addressData': jsonAddressData }),
                contentType: "application/json",
                success: function (res) {
                    console.log(res.d);
                    var parsedData = JSON.parse(res.d);
                    var sugg = parsedData.data[0];
                    var suggestedAddress = "";
                    if (sugg.line1) {
                        suggestedAddress += sugg.line1 + "\n";
                    }
                    if (sugg.line2) {
                        suggestedAddress += sugg.line2 + "\n";
                    }
                    if (sugg.city) {
                        suggestedAddress += sugg.city + ", ";
                    }
                    if (sugg.provinceOrStateName) {
                        suggestedAddress += sugg.provinceOrStateName + "\n";
                    }
                    if (sugg.countryName) {
                        suggestedAddress += sugg.countryName + "\n";
                        if (sugg.postalOrZip) {
                            suggestedAddress += sugg.postalOrZip;
                        }
                        console.log(suggestedAddress);
                        $("#txtSuggestedAddress").val(suggestedAddress);
                        $("#txtOriginalAddress").val(originalAddress);
                        $("#exampleModal").modal("show");

                    }
                },
                    error: function (err) {
                        if (err.responseJSON && err.responseJSON.message) {
                            alert(err.responseJSON.message);
                        } else if (err.responseText) {
                            alert(err.responseText);
                        } else {
                            alert("An error occurred");
                        }
                    }

           });

        }

        function btnOnSugg() {
            var suggestedAddress = $("#txtSuggestedAddress").val();
            var addressLines = suggestedAddress.split('\n');

           
            var line1 = addressLines[0];
            if (addressLines.length == 5) {
                var line2 = addressLines[1];
                var cityState = addressLines[2].split(', ');
                var city = cityState[0];
                var state = cityState[1];
                var country = addressLines[3];
                var postalZip = addressLines[4];
            }
            else {
                var cityState = addressLines[1].split(', ');
                var city = cityState[0];
                var state = cityState[1];
                var country = addressLines[2];
                var postalZip = addressLines[3];
            }
            $("#txtAddressLine1").val(line1);

            if (line2) {
                $("#txtAddressLine2").val(line2);
            }

            $("#txtCity").val(city);
            $("#txtState").val(state);
            $("#txtCountry").val(country);
            $("#txtPostalCode").val(postalZip);
            
        }
       
        function btnOnSignUp() {
            var name = $("#txtName").val();
            var email = $("#txtEmail").val();
            var password = $("#txtPass").val();
            var mobile = $("#txtMobile").val();
            var addressLine1 = $("#txtAddressLine1").val();
            var addressLine2 = $("#txtAddressLine2").val();
            var city = $("#txtCity").val();
            var state = $("#txtState").val();
            var country = $("#txtCountry").val();
            var PostalCode = $("#txtPostalCode").val();


            var objData = {
                name: name,
                email: email,
                password: password,
                mobile: mobile,
                addressLine1: addressLine1,
                addressLine2: addressLine2,
                city: city,
                state: state,
                country: country,
                PostalCode: PostalCode
            };

            var userData = JSON.stringify(objData);

            $.ajax({               
                type: "POST",
                url: "CreateUser.asmx/signUp",
                async: false,
                cache: false,
                data: JSON.stringify({ 'userData': userData }),
                contentType: "application/json",
                success: function (res) {
                    alert(res.d);
                },
                error: function (err) {
                    if (err.responseJSON && err.responseJSON.message) {
                        alert(err.responseJSON.message);
                    } else if (err.responseText) {
                        alert(err.responseText);
                    } else {
                        alert("An error occurred");
                    }
                }
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
                                    <img src="Images/generaluser.png" width="100px" />
                                    <h5>Member SignUp</h5>
                                </center>
                                <hr />
                            </div>
                            <div class="row">
                                <div class="col">
                                    <center>
                                        <div class="form-group">
                                            <input type="text" class="form-control mb-1" placeholder="Full Name" id="txtName" />
                                            <input type="email" class="form-control mb-1" placeholder="Email" id="txtEmail" />
                                        </div>

                                        <div class="form-group">
                                            <input type="text" class="form-control mb-1" placeholder="Password" id="txtPass" />
                                        </div>
                                        <div class="form-group">
                                            <input type="text" class="form-control mb-1" placeholder="Mobile Number" id="txtMobile" />
                                        </div>
                                    </center>
                                </div>

                            </div>
                            <div class="row">
                                <center>
                                    <div class="form-group">

                                        <input type="text" class="form-control mb-1" placeholder="Address Line1" id="txtAddressLine1" />
                                    </div>
                                </center>
                            </div>
                            <div class="row">
                                <center>
                                    <div class="form-group">

                                        <input type="text" class="form-control mb-1" placeholder="Address Line2" id="txtAddressLine2" />
                                    </div>
                                </center>


                            </div>
                            <div class="row">
                                <center>
                                    <div class="form-group">

                                        <input type="text" class="form-control mb-1" placeholder="City" id="txtCity" />
                                    </div>
                                </center>


                            </div>
                            <div class="row">
                                <center>
                                    <div class="form-group">

                                        <input type="text" class="form-control mb-1" placeholder="State" id="txtState" />
                                    </div>
                                </center>


                            </div>
                            <div class="row">
                                <center>
                                    <div class="form-group">

                                        <input type="text" class="form-control mb-1" placeholder="Country" id="txtCountry" />
                                    </div>
                                </center>


                            </div>
                            <div class="row">
                                <center>
                                    <div class="form-group">

                                        <input type="text" class="form-control mb-1" placeholder="Postal Code" id="txtPostalCode" />
                                    </div>
                                </center>


                            </div>

                            <div class="row">
                                <div class="form-group">
                                    <center>
                                        <input type="button" class="btn btn-info btn-block btn-lg mb-1" value="SignUp" onclick="btnOnSignUp(this);return false" />
                                        <input type="button" class="btn btn-warning btn-md mb-1" value="Validate Address" onclick="btn_validateAddress(this); return false" />
                                    </center>

                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Address Suggestion</h5>
                        <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-md-6">
                                <div id="Suggested Address">
                                    <div class="form-group">
                                        <label for="exampleFormControlTextarea1">Suggested Address</label>
                                        <textarea class="form-control" id="txtSuggestedAddress" rows="3"></textarea>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div id="TypedAddress">
                                    <div class="form-group">
                                        <label for="exampleFormControlTextarea1">Original Address</label>
                                        <textarea class="form-control" id="txtOriginalAddress" rows="3"></textarea>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-warning" data-bs-dismiss="modal" onclick="btnOnSugg(this); return false">Use Suggested</button>
                        <button type="button" class="btn btn-primary" data-bs-dismiss="modal" onclick="btnOnOrg(this); return false">Use Original</button>
                    </div>
                </div>
            </div>
        </div>
    </section>
</asp:Content>
