using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SIMANET_W22R.InterfaceUI
{
    public interface IPaginaBase
    {
		/// </summary>
		void LlenarGrilla();

		/// <summary>
		/// Llena el grid y lo ordena por la columna indicada
		/// </summary>
		void LlenarGrilla(string strFilter);

		/// <summary>
		/// LLena los combos del formulario web
		/// </summary>
		void LlenarCombos();

		/// <summary>
		/// Llena los datos en el formulario web
		/// </summary>
		void LlenarDatos();
	
		/*int Agregar();
		int Modificar();*/
		/// <summary>
		/// Asigna javaScript a los controles del formulario web
		/// </summary>
		void LlenarJScript();

		/// <summary>
		/// Registra javaScript en el formulario web
		/// </summary>
		void RegistrarJScript();

		/// <summary>
		/// Imprime los datos
		/// </summary>
		void Imprimir();
		/// <summary>
		/// Exporta los datos
		/// </summary>
		void Exportar();

		/// <summary>
		/// Configura las controles del formulario web en base a los privilegios del perfil
		/// </summary>
		void ConfigurarAccesoControles();


		/// <summary>
		/// Valida los filtros a emplear
		/// </summary>
		bool ValidarFiltros();
		bool ValidarDatos();

	}
}
