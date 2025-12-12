<%@ Page Language="C#" MasterPageFile="~/admin/AdminMaster.master" AutoEventWireup="true" CodeBehind="nuevo-local.aspx.cs" Inherits="ClinicaWeb.admin.nuevo_local" %>

<asp:Content ID="TitleContent" ContentPlaceHolderID="TitleContent" runat="server">
    Nuevo Local - NeoSalud
</asp:Content>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="pagina-gestion">
        <div class="encabezado-gestion">
            <h1>Nuevo Local</h1>
            <div class="acciones-gestion">
                <asp:LinkButton ID="btnGuardar" runat="server" CssClass="btn btn-principal" OnClick="btnGuardar_Click">
                    <i class="fas fa-save"></i> Guardar
                </asp:LinkButton>
                <asp:LinkButton ID="btnCancelar" runat="server" CssClass="btn btn-secundario" OnClick="btnCancelar_Click">
                    <i class="fas fa-times"></i> Cancelar
                </asp:LinkButton>
            </div>
        </div>

        <div class="formulario-gestion">
            <div class="grid-formulario">
                <div class="form-grupo">
                    <label for="txtDireccion">Dirección</label>
                    <asp:TextBox ID="txtDireccion" runat="server" CssClass="form-control" required></asp:TextBox>
                </div>

                <div class="form-grupo">
                    <label for="txtUbigeo">Ubigeo</label>
                    <asp:TextBox ID="txtUbigeo" runat="server" CssClass="form-control" required></asp:TextBox>
                </div>

                <asp:ScriptManager ID="ScriptManager1" runat="server" />
                <div class="form-grupo">
                    <label for="ddlDepartamento">Departamento</label>
                    <asp:UpdatePanel ID="upDepartamentoCiudad" runat="server">
                        <ContentTemplate>
                            <asp:DropDownList ID="ddlDepartamento" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlDepartamento_SelectedIndexChanged" CssClass="form-control" />
                            <br />
                            <label for="ddlCiudad">Ciudad</label>
                            <asp:DropDownList ID="ddlCiudad" runat="server" CssClass="form-control" />
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>

                <div class="form-grupo">
                    <label for="lstEspecialidades">Especialidades</label>
                    <asp:CheckBoxList ID="chkEspecialidades" runat="server" CssClass="form-check" RepeatLayout="Table" RepeatDirection="Vertical" />
                </div>

                <div class="form-grupo">
                    <label for="ddlEstado">Estado</label>
                    <asp:DropDownList ID="ddlEstado" runat="server" CssClass="form-control">
                        <asp:ListItem Text="Activo" Value="1"></asp:ListItem>
                        <asp:ListItem Text="Inactivo" Value="0"></asp:ListItem>
                    </asp:DropDownList>
                </div>

                <!-- Consultorios -->
                <div class="form-grupo">
                    <label>Consultorios</label>

                    <div class="row">
                        <div class="col-md-4">
                            <asp:TextBox ID="txtNumConsultorio" runat="server" CssClass="form-control" placeholder="N° Consultorio" />
                        </div>
                        <div class="col-md-4">
                            <asp:TextBox ID="txtPisoConsultorio" runat="server" CssClass="form-control" placeholder="Piso" />
                        </div>
                        <div class="col-md-4">
                            <asp:DropDownList ID="ddlDoctores" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddlDoctores_SelectedIndexChanged">
                            </asp:DropDownList>
                            <asp:TextBox ID="txtCodigoMedico" runat="server" CssClass="form-control mt-2" placeholder="Código Médico" ReadOnly="true" Style="background-color: #e9ecef;" />
                        </div>
                    </div>

                    <asp:LinkButton ID="btnAgregarConsultorio" runat="server" CssClass="btn btn-info mt-2" OnClick="btnAgregarConsultorio_Click">
                        <i class="fas fa-plus"></i> Agregar Consultorio
                    </asp:LinkButton>

                    <asp:GridView ID="gvConsultorios" runat="server" AutoGenerateColumns="False"
                        OnRowCommand="gvConsultorios_RowCommand" DataKeyNames="numConsultorio" CssClass="table table-striped">
                        <Columns>
                            <asp:BoundField DataField="numConsultorio" HeaderText="N° Consultorio" />
                            <asp:BoundField DataField="piso" HeaderText="Piso" />
                            <asp:TemplateField HeaderText="Código Médico">
                                <ItemTemplate>
                                    <%# Eval("codigoMedico") %>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Estado">
                                <ItemTemplate>
                                    <asp:DropDownList ID="ddlEstadoConsultorio" runat="server" CssClass="form-control" SelectedValue='<%# Eval("activo") %>'>
                                        <asp:ListItem Text="Activo" Value="1" />
                                        <asp:ListItem Text="Inactivo" Value="0" />
                                    </asp:DropDownList>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:LinkButton ID="btnEliminar" runat="server" CommandName="Eliminar" CommandArgument='<%# Eval("numConsultorio") %>' CssClass="btn btn-danger btn-sm">
                                        <i class="fas fa-trash"></i> Eliminar
                                    </asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>
                <!-- Fin Consultorios -->

                <script type="text/javascript">
                    function actualizarCodigoMedico() {
                        var ddl = document.getElementById("<%= ddlDoctores.ClientID %>");
                        var txt = document.getElementById("<%= txtCodigoMedico.ClientID %>");
                        txt.value = ddl.value;
                    }
                </script>

            </div>
        </div>
    </div>
</asp:Content>
