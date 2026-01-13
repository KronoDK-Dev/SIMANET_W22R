using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SIMANET_W22R.Controles
{
    using EasyControlWeb;
    using System;
    using System.Collections.Generic;
    using System.Net.Mail;
    

    public class MailResult{
        public string Message{  get; set; }
        public bool Exitoso { get; set; }
        public MailResult(string message, bool exitoso)
        {
            Message = message;
            Exitoso = exitoso;
        }
    }

    public class Mail
    {

        string From = ""; //de quien procede, puede ser un alias
        string To;  //a quien vamos a enviar el mail
        string []Cc;  //Copn copia a quien mas de puede enviar el mail
        string Message;  //mensaje
        string Subject; //asunto
        List<string> Archivo = new List<string>(); //lista de archivos a enviar
        string DE = ""; //nuestro usuario de smtp
        string PASS = ""; //nuestro password de smtp y el atibuto smtpMail.UseDefaultCredentials = false;
        System.Net.Mail.MailMessage Email;

        public string error = "";
        public Mail(string FROM, string Para,string []_Cc, string Mensaje, string Asunto, List<string> ArchivoPedido_ = null)
        {
            From = FROM;
            To = Para;
            Cc = ((_Cc.Length>0)?_Cc:null);
            Message = Mensaje;
            Subject = Asunto;
            Archivo = ArchivoPedido_;

        }
        public Mail(string FROM, string Para,  string Mensaje, string Asunto, List<string> ArchivoPedido_ = null)
        {
            From = FROM;
            To = Para;
            Cc = null;
            Message = Mensaje;
            Subject = Asunto;
            Archivo = ArchivoPedido_;

        }
        public Mail(string FROM, string Para, string Mensaje, string Asunto)
        {
            From = FROM;
            To = Para;
            Cc = null;
            Message = Mensaje;
            Subject = Asunto;
            Archivo = null;

        }

        public MailResult enviaMail()
        {
            string _strMsg = "";
            bool Enviar = true;
            //una validación básica
            if (To.Trim().Equals("") )
            {
                _strMsg = "El mail del destino no se ha ingresado";
                Enviar=false;
            }
            if (Message.Trim().Equals(""))
            {
                _strMsg +=((_strMsg.Length>0)? " y " : "") + "El mensaje no se ha ingresado";
                Enviar = false;
            }
            if (Subject.Trim().Equals(""))
            {
                _strMsg += ((_strMsg.Length > 0) ? " y " : "") + "El Asunto no se ha ingresado";
                Enviar = false;
            }
            if (From.Trim().Equals(""))
            {
                _strMsg += ((_strMsg.Length > 0) ? " y " : "") + "El eMail del remitente no se ha ingresado";
                Enviar = false;
            }

            if (Enviar == false) {
                return new MailResult(_strMsg, Enviar);
            }
            //aqui comenzamos el proceso
            //comienza-------------------------------------------------------------------------
            try
            {
                //creamos un objeto tipo MailMessage
                //este objeto recibe el sujeto o persona que envia el mail,
                //la direccion de procedencia, el asunto y el mensaje
                Email = new System.Net.Mail.MailMessage(From, To,Subject, Message);

                //si viene archivo a adjuntar
                //realizamos un recorrido por todos los adjuntos enviados en la lista
                //la lista se llena con direcciones fisicas, por ejemplo: c:/pato.txt
                if (Archivo != null)
                {
                    //agregado de archivo
                    foreach (string archivo in Archivo)
                    {
                        //comprobamos si existe el archivo y lo agregamos a los adjuntos
                        if (System.IO.File.Exists(@archivo))
                            Email.Attachments.Add(new Attachment(@archivo));

                    }
                }

                Email.IsBodyHtml = true; //definimos si el contenido sera html
                
                Email.From = new MailAddress(From); //definimos la direccion de procedencia
                if (Cc != null)
                {
                    foreach (string cc in Cc)
                    {
                        Email.CC.Add(new MailAddress(cc));
                    }
                }
                //aqui creamos un objeto tipo SmtpClient el cual recibe el servidor que utilizaremos como smtp
                //en este caso me colgare de gmail
                System.Net.Mail.SmtpClient smtpMail = new System.Net.Mail.SmtpClient("smtp.gmail.com");

                smtpMail.EnableSsl = false;//le definimos si es conexión ssl
                smtpMail.UseDefaultCredentials = true; //le decimos que no utilice la credencial por defecto
                smtpMail.Host = EasyUtilitario.Helper.Configuracion.Leer(EasyUtilitario.Enumerados.Configuracion.SeccionKey.Nombre.ConfigBase, "ServerEMail");//  "10.10.90.77"; //agregamos el servidor smtp
                smtpMail.Port = Convert.ToInt32(EasyUtilitario.Helper.Configuracion.Leer(EasyUtilitario.Enumerados.Configuracion.SeccionKey.Nombre.ConfigBase, "ServerEMailPort")); ; //le asignamos el puerto, en este caso gmail utiliza el 465
                //smtpMail.Credentials = new System.Net.NetworkCredential(DE, PASS); //agregamos nuestro usuario y pass de gmail
                //enviamos el mail
                smtpMail.Send(Email);

                //eliminamos el objeto
                smtpMail.Dispose();

                //regresamos true
                return new MailResult("Se envio correo de manera satisfatoria", true);
            }
            catch (Exception ex)
            {
                //si ocurre un error regresamos false y el error
                _strMsg = ex.Message.Replace("'"," ");
                //throw new Exception(_strMsg);
            }

            return new MailResult(_strMsg, false);

        }

    }
}