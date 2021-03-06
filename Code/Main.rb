begin
  require 'rubygems'
 rescue LoadError
end

require 'gtk3'
require "thread"
require "digest"

Gtk.init

$LOAD_PATH.unshift File.dirname(__FILE__)

require "Classes/Interface/Header.rb"
require "Classes/Interface/Pages/ConnexionOuCreation_Page.rb"
require "Classes/Interface/Pages/Compte_Page.rb"
require "Classes/MethodSauvegard.rb"

def onDestroy
	puts "Fin de l'application"
	Gtk.main_quit
end

def configureMonApp(uneApp)
  ##
  # Taille de la fenêtre
	uneApp.set_default_size(700,400)
	##
  # Réglage de la bordure
	uneApp.border_width=5
	##
  # On ne peut pas redimensionner
	uneApp.set_resizable(true)
	##
  #L'application est toujours centrée
	uneApp.set_window_position(Gtk::WindowPosition::CENTER_ALWAYS)
end


if ARGV.size.eql?(0) then
  ##
  # Creation de la fenetre et configuration
  monApp = Gtk::Window.new
  configureMonApp(monApp)

  # Titre de la fenêtre
	header = Header.new(monApp)
  #puts Gtk.major_version
  #puts Gtk.minor_version
  #puts Gtk.micro_version
  ##
  # crée le dossier de Sauvegarde
  #Dir.mkdir 'Sauvegarde'

  $joueur = nil
  $sv = MethodSauvegard.new
  ######DEBUT#########

  ##
  # Box principale
  choixConnexionCreation = ConnexionOuCreation_Page.new(monApp, header, nil)

  choixConnexionCreation.ajouteMoi

  ######FIN########


  ##
  # Ajout du header a la fenetre
  monApp.titlebar = header

	monApp.show_all

	##
  #Quand la fenêtre est détruite il faut quitter
	monApp.signal_connect('destroy') {onDestroy}

	Gtk.main

else
	puts "Usage Error O argument pour le Picross"
end
