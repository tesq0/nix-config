{ stdenv
, lib
, fetchurl
, autoPatchelfHook
, unzip
, makeWrapper
, icu, zlib, lttng-ust, krb5, openssl
}:

stdenv.mkDerivation rec {

  name = "razor-server";
  version = "6.0.0";

  src = fetchurl {
    url = "https://download.visualstudio.microsoft.com/download/pr/757f5246-2b09-43fe-9a8d-840cfd15092b/2b6d8eee0470acf725c1c7a09f8b6475/razorlanguageserver-linux-x64-6.0.0-alpha.1.20418.9.zip";
    sha256 = "1hksxq867anb9h040497phszq64f6krg4a46w0xqrm6crj8znqr5";
  };

  unpackPhase = ''
    ${unzip}/bin/unzip -d src "$src" || true
  '';

  dontStrip = true;

  nativeBuildInputs = [ autoPatchelfHook makeWrapper ];

  propagatedBuildInputs = [ stdenv.cc.cc icu zlib lttng-ust krb5 openssl ];

  installPhase = ''
    mkdir -p $out/bin
    ls -al
    cd src
    mv * $out/

    binFile=rzls

    cd $out
    
    chmod +x $binFile
    
    wrapProgram "$out/$binFile" \
    --prefix LD_LIBRARY_PATH : "${lib.makeLibraryPath propagatedBuildInputs}"

    ln -sf $out/$binFile $out/bin/$binFile

  '';

  meta = with lib; {
    description = "Razor Language Server";
    homepage = "https://github.com/dotnet/aspnetcore-tooling/tree/master/src/Razor";
    platforms = platforms.linux;
    license = licenses.asl20;
    maintainers = with maintainers; [ tesq0 ];
  };

}
