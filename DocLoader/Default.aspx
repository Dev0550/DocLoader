<%@ Page Title="MyBabilon" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="DocLoader._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
    <script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
    <script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
    <!------ Include the above in your HEAD tag ---------->

    <style>
        .btn-file {
            position: relative;
            overflow: hidden;
        }

            .btn-file input[type=file] {
                position: absolute;
                top: 0;
                right: 0;
                min-width: 100%;
                min-height: 100%;
                font-size: 100px;
                text-align: right;
                filter: alpha(opacity=0);
                opacity: 0;
                outline: none;
                background: white;
                cursor: inherit;
                display: block;
            }

        #img-upload {
            width: 100%;
        }
    </style>
    <div>
        <div>
            <div class="container">
                <div class="page-header">
                    <h1>Загрузите документы</h1>
                    <h5>Загрузите необходимые документы для дальнейшего рассмотрения вашей заявки.</h5>
                </div>
                <div class="alert alert-info">
                    Файл должен быть в формате jpg, png или pdf, объёмом не больше 5 Мб.
                </div>
                    <asp:Label ID="lblmsg" runat="server" Text=""></asp:Label>
                <br>
                <br>
                <div class="form-group">
                    <label>Введите ИНН</label>
                    <div class="d-flex" style="width: 100%">
                        <asp:TextBox ID="txtTin" class="form-control" runat="server" required="" placeholder="Пример - 123456789" Style="font-size: 16px; max-width: 373px;"></asp:TextBox>
                        <asp:RegularExpressionValidator ID="revTin" runat="server" ControlToValidate="txtTin" ForeColor="Red" ValidationExpression="^[0-9]{9}$"
                            ErrorMessage="Поле 'ИНН' может содержат только 9 цифр" Display="Static"></asp:RegularExpressionValidator>
                    </div>
                </div>

                <div class="form-group">
                    <label for="fileName">Загрузите лицевая сторона паспорта</label>
                    <div class="input-group" style="margin-bottom: 10px;">
                        <span class="input-group-btn">
                            <span class="btn btn-default btn-file">Выбрать…
                                    <input type="file" id="imgInp1" runat="server" accept=".jpg, .jpeg, .png" clientidmode="Static" required>
                            </span>
                        </span>
                        <input type="text" class="form-control" readonly>
                    </div>
                    <img id='img-upload1' />
                </div>
                <div class="form-group">
                    <label for="fileName">Загрузите обратная сторона паспорта</label>
                    <div class="input-group" style="margin-bottom: 10px;">
                        <span class="input-group-btn">
                            <span class="btn btn-default btn-file">Выбрать…
                                    <input type="file" id="imgInp2" runat="server" accept=".jpg, .jpeg, .png" clientidmode="Static" required>
                            </span>
                        </span>
                        <input type="text" class="form-control" readonly>
                    </div>
                    <img id='img-upload2' />
                </div>

                <div>
                    <button type="reset" class="btn btn-default" onclick="window.location.reload();">Сброс</button>
                    <asp:Button ID="btn_save1" runat="server" Text="Отправить" class="btn btn-primary" OnClick="SaveData_Click" />
                </div>

            </div>
        </div>
    </div>
    <script>
        $(document).ready(function () {
            $(document).on('change', '.btn-file :file', function () {
                var input = $(this),
                    label = input.val().replace(/\\/g, '/').replace(/.*\//, '');
                input.trigger('fileselect', [label]);
            });

            $('.btn-file :file').on('fileselect', function (event, label) {

                var input = $(this).parents('.input-group').find(':text'),
                    log = label;

                if (input.length) {
                    input.val(log);
                } else {
                    if (log) alert(log);
                }
            });
            function readURL(input) {
                if (input.files && input.files[0]) {
                    var reader = new FileReader();

                    reader.onload = function (e) {
                        $('#img-upload1').attr('src', e.target.result);
                    }
                    reader.readAsDataURL(input.files[0]);
                }
            }
            $("#imgInp1").change(function () {
                readURL(this);
            });
        });
    </script>

    <script>
        $(document).ready(function () {
            $(document).on('change', '.btn-file :file', function () {
                var input = $(this),
                    label = input.val().replace(/\\/g, '/').replace(/.*\//, '');
                input.trigger('fileselect', [label]);
            });

            $('.btn-file :file').on('fileselect', function (event, label) {

                var input = $(this).parents('.input-group').find(':text'),
                    log = label;

                if (input.length) {
                    input.val(log);
                } else {
                    if (log) alert(log);
                }
            });
            function readURL(input) {
                if (input.files && input.files[0]) {
                    var reader = new FileReader();

                    reader.onload = function (e) {
                        $('#img-upload2').attr('src', e.target.result);
                    }
                    reader.readAsDataURL(input.files[0]);
                }
            }
            $("#imgInp2").change(function () {
                readURL(this);
            });
        });
    </script>

</asp:Content>

