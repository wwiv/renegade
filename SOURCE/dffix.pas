{$IFDEF WIN32}
{$I DEFINES.INC}
{$ENDIF}
unit dffix;
{
  code: 276
}
interface

uses dos;

function  diskkbfree(drive:byte):longint;

implementation

{$IFDEF MSDOS}
function diskkbfree(drive:byte):longint;
var
  regs:registers;

begin
  regs.ah := $36;
  regs.dl := drive;
  intr($21,regs);
  diskkbfree := longint(regs.bx) * ((longint(regs.ax) * regs.cx) div 1024);
end;
{$ENDIF}
{$IFDEF WIN32}
function diskkbfree(drive:byte):longint;
begin
  // REETODO Throws an error when checking drive a (drive=1)
  //         Presumably this is only because my drive a is empty
  diskkbfree := DiskFree(drive) div 1024;
end;
{$ENDIF}

end.
