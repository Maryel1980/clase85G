import React, { Component } from 'react';
import { Text, View, StyleSheet, SafeAreaView, Platform, Image, Switch, StatusBar } from 'react-native';
import {RFValue} from "react-native-responsive-fontsize";
import AppLoading from "expo-app-loading";
import * as Font from "expo-font";
import firebase from "../config";

let customFonts = {
  "Bubblegum-Sans": require("../assets/fonts/BubblegumSans-Regular.ttf"),
};

export default class Profile extends Component {
  constructor(props){
    super (props);
    this.state={
      fontsLoaded: false,
      isEnable:false,
      light_theme:true,
      profile_image: "",
      name: ""
    }
  }

toggleSwitch(){
  const previous_state= this.state.isEnable;
  const theme= !this.state.isEnable ? "dark" : "light";
  var userRef = firebase.ref ("/users/jT9vClO81vPtMCjuCrUMAQpuAYc2").update({
    current_theme: theme
  })
  this.setState({isEnable: !previous_state, light_theme: previous_state })
}

async _loadFontsAsync() {
    await Font.loadAsync(customFonts);
    this.setState({ fontsLoaded: true });
  }

  componentDidMount() {
    this._loadFontsAsync();
    this.fetchUser();
  }

  async fetchUser(){
    this.setState({
      light_theme: theme == "light" ? true: false,
      isEnable: theme == "light" ? false:true,
      name: name,
      profile_image: image
    })
  }


    render() {
      if (!this.state.fontsLoaded){
          return <AppLoading/>
      } else {
          return (
            <View
                style={this.state.light_theme ? styles.containerLight: styles.container}>     
                 <SafeAreaView style={styles.droidSafeArea}/> 
                    <View style={styles.appTitle}>
                      <View style={styles.appIcon}>
                        <Image source= {require("../assets/logo.png")}
                        style={styles.iconImage}>
                        </Image>
                      </View> 
                      <View style={styles.appTitleTextContainer}> 
                         <Text style={this.state.light_theme ?
                          styles.appTitleTextLight : styles.appTitleText}>Aplicación Narrar Historias</Text>
                      </View>   
                    </View>
                    <View  style={styles.themeContainer}>
                       <Text style={ this.state.light_theme ? 
                       styles.themeTextLight : styles.themeText}>Dark Theme</Text>
                    
                    <Switch style = {{transform : [{ scaleX: 1.3}, {scaleY:1.3}]}} 
                      trackColor={{
                        false: "#149DA2",
                        true: this.state.light_theme ? "#eee" : "white"
                      }}
                      thumbColor={this.state.isEnable ? "#ee8249": "#f4f3f4"}
                      ios_backgroundColor="#3e3e3e"
                      onValueChange={() => this.toggleSwitch()}
                      value= {this.state.isEnable}
                    /> 

                    </View>
               
            </View>
        )
      }
    }
}


const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: "#15193c"
  },
  containerLight: {
    flex: 1,
    backgroundColor: "white"
  },
    droidSafeArea: {
    marginTop: Platform.OS === "android" ? StatusBar.currentHeight : RFValue(35)
  },
  appTitle: {
    flex: 0.07,
    flexDirection: "row"
  },
  appIcon: {
    flex: 0.3,
    justifyContent: "center",
    alignItems: "center"
  },
  iconImage: {
    width: "100%",
    height: "100%",
    resizeMode: "contain"
  },
  appTitleTextContainer: {
    flex: 0.7,
    justifyContent: "center"
  },
  appTitleText: {
    color: "white",
    fontSize: RFValue(28),
    fontFamily: "Bubblegum-Sans"
  },
  appTitleTextLight: {
    color: "black",
    fontSize: RFValue(28),
    fontFamily: "Bubblegum-Sans"
  },
  themeContainer: {
    flex: 0.2,
    flexDirection: "row",
    justifyContent: "center",
    marginTop: RFValue(20)
  },
  themeText: {
    color: "white",
    fontSize: RFValue(30),
    fontFamily: "Bubblegum-Sans",
    marginRight: RFValue(15)
  },
  themeTextLight: {
    color: "black",
    fontSize: RFValue(30),
    fontFamily: "Bubblegum-Sans",
    marginRight: RFValue(15)
  }
})
