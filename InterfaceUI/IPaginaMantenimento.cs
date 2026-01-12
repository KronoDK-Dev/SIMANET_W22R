using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SIMANET_W22R.InterfaceUI
{
    public interface IPaginaMantenimento
    {
		void Agregar();

		void Modificar();

		void Eliminar();

		void CargarModoPagina();

		void CargarModoNuevo();

		void CargarModoModificar();

		void CargarModoConsulta();

		bool ValidarCampos();

		bool ValidarCamposRequeridos();

		bool ValidarExpresionesRegulares();
	}
}
